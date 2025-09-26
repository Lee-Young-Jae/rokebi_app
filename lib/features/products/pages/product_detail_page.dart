import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../viewmodels/product_detail_view_model.dart';
import '../widget/product_banner.dart';
import '../widget/product_tab_bar.dart';
import '../widget/product_plan_list.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  String _currentTab = '';
  final ScrollController _scrollController = ScrollController();
  AnimationController? _animationController;
  Animation<double>? _animation;

  // 토스트 알림 관련
  AnimationController? _toastAnimationController;
  Animation<double>? _toastAnimation;
  Timer? _toastTimer;
  bool _showToast = false;

  bool _isCollapsed = false;
  static const double _bannerHeight = 170.0;
  static const double _snapThreshold = 100.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );

    // 토스트 애니메이션 컨트롤러 초기화
    _toastAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _toastAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _toastAnimationController!,
        curve: Curves.easeOutBack,
      ),
    );

    _scrollController.addListener(_handleScroll);

    // 토스트 표시
    _scheduleToastMessage();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    _animationController?.dispose();
    _toastAnimationController?.dispose();
    _toastTimer?.cancel();
    super.dispose();
  }

  void _handleScroll() {
    final offset = _scrollController.offset;

    if (offset > _snapThreshold && !_isCollapsed) {
      _collapseHeader();
    } else if (offset <= 0 && _isCollapsed) {
      _expandHeader();
    }
  }

  void _collapseHeader() {
    setState(() {
      _isCollapsed = true;
    });
    _animationController?.forward();
  }

  void _expandHeader() {
    setState(() {
      _isCollapsed = false;
    });
    _animationController?.reverse();
  }

  void _scheduleToastMessage() {
    // 바로 토스트 메시지 표시
    _toastTimer = Timer(const Duration(milliseconds: 500), () {
      _showToastMessage();
    });
  }

  void _showToastMessage() {
    if (!mounted) return;

    setState(() {
      _showToast = true;
    });

    _toastAnimationController?.forward();

    // 3초 후에 토스트 숨기기
    Timer(const Duration(seconds: 3), () {
      _hideToastMessage();
    });
  }

  void _hideToastMessage() {
    if (!mounted) return;

    // 사라지는 애니메이션 시작
    _toastAnimationController?.reverse().then((_) {
      if (mounted) {
        setState(() {
          _showToast = false;
        });
      }
    });
  }

  void _initializeTabController(List<String> tabs) {
    if (tabs.isNotEmpty &&
        (_tabController == null || _tabController!.length != tabs.length)) {
      _tabController?.dispose();
      _tabController = TabController(length: tabs.length, vsync: this);
      _tabController!.addListener(() {
        if (_tabController!.indexIsChanging) {
          _currentTab = tabs[_tabController!.index];
          Future.microtask(() {
            ref
                .read(productDetailViewModelProvider(widget.productId).notifier)
                .loadPlansForTab(_currentTab);
          });
        }
      });

      if (tabs.isNotEmpty) {
        _currentTab = tabs[0];

        Future.microtask(() {
          ref
              .read(productDetailViewModelProvider(widget.productId).notifier)
              .loadPlansForTab(_currentTab);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailViewModelProvider(widget.productId));

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.error != null) {
      return Scaffold(body: Center(child: Text('Error: ${state.error}')));
    }

    if (state.product == null) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    // TabController 초기화
    if (state.availableTabs.isNotEmpty) {
      _initializeTabController(state.availableTabs);
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              // Deep Link로 진입한 경우 홈으로 이동
              context.go('/home');
            }
          },
        ),
        title: Text(
          state.product!.title,
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: state.availableTabs.isEmpty
          ? _EmptyProductDetailWidget(productName: state.product?.title ?? '상품')
          : Stack(
              children: [
                // 상단 나라 이미지 배너
                ProductBanner(product: state.product!),

                // 토스트 메시지 오버레이
                if (_showToast && _toastAnimation != null)
                  AnimatedBuilder(
                    animation: _toastAnimation!,
                    builder: (context, child) {
                      final animationValue = _toastAnimation!.value.clamp(
                        0.0,
                        1.0,
                      );
                      return Positioned(
                        top: _bannerHeight - 60 + (30 * (1.0 - animationValue)),
                        left: 0,
                        right: 0,
                        child: Opacity(
                          opacity: animationValue.clamp(0.0, 1.0),
                          child: Center(
                            child: _PurchaseToastWidget(
                              productName: state.product?.title ?? '상품',
                              purchaseCount:
                                  state.product?.purchaseCount ?? '구매 1만+',
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                // 탭바 (토스트보다 앞에 위치)
                AnimatedBuilder(
                  animation: _animation!,
                  builder: (context, child) {
                    final slideOffset = _animation!.value * _bannerHeight;

                    return Transform.translate(
                      offset: Offset(0, _bannerHeight - slideOffset),
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.surface),
                        child: Column(
                          children: [
                            // 탭바
                            ProductTabBar(
                              tabs: state.availableTabs,
                              tabController: _tabController,
                            ),

                            // 탭뷰 내용
                            Expanded(
                              child: _tabController != null
                                  ? TabBarView(
                                      controller: _tabController,
                                      children: state.availableTabs
                                          .map(
                                            (tab) => SingleChildScrollView(
                                              controller: _scrollController,
                                              child: ProductPlanList(
                                                tabType: tab,
                                                state: state,
                                                productId: widget.productId,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class _EmptyProductDetailWidget extends StatelessWidget {
  final String productName;

  const _EmptyProductDetailWidget({required this.productName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AppSpacing.heightXXL,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SVG 아이콘
                SvgPicture.asset(
                  'assets/icons/iconNoCart.svg',
                  width: 140,
                  height: 140,
                ),
                AppSpacing.heightXXL,
                Text(
                  '$productName 요금제 준비 중입니다',
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.heightMD,
                Text(
                  '곧 다양한 요금제를 제공할 예정입니다.\n잠시만 기다려 주세요!',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PurchaseToastWidget extends StatelessWidget {
  final String productName;
  final String purchaseCount;

  const _PurchaseToastWidget({
    required this.productName,
    required this.purchaseCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_active, color: AppColors.warning, size: 20),
          const SizedBox(width: 12),
          Flexible(
            child: RichText(
              text: TextSpan(
                style: AppTypography.bodySmall.copyWith(
                  color: Colors.white,
                  height: 1.3,
                ),
                children: [
                  const TextSpan(text: '최근 일주일간 '),
                  TextSpan(
                    text: '3,320명',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: '이 구매한 상품이에요!'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
