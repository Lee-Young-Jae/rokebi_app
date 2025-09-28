import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rokebi_app/core/constants/app_colors.dart';
import 'package:rokebi_app/core/constants/app_typography.dart';
import 'package:rokebi_app/features/products/widget/product_card.dart';
import 'package:rokebi_app/features/products/widget/search_button.dart';
import 'package:rokebi_app/features/products/widget/banner_carousel.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../models/product_model.dart';
import '../viewmodels/product_list_view_model.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _isBannerVisible = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// iOS에서 실제 마이크 접근을 시도하여 권한 팝업을 강제로 트리거
  Future<void> _triggerIOSMicrophoneRequest() async {
    if (!Platform.isIOS) return;

    try {
      print(
        '🎤 [Home] Triggering iOS microphone access for permission popup...',
      );

      // AudioSession을 통해 마이크 사용을 시도
      final session = await AudioSession.instance;
      await session.configure(
        const AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.record,
          avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.none,
          avAudioSessionMode: AVAudioSessionMode.defaultMode,
          avAudioSessionRouteSharingPolicy:
              AVAudioSessionRouteSharingPolicy.defaultPolicy,
          avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
          androidAudioAttributes: AndroidAudioAttributes(
            contentType: AndroidAudioContentType.speech,
            flags: AndroidAudioFlags.none,
            usage: AndroidAudioUsage.voiceCommunication,
          ),
          androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
          androidWillPauseWhenDucked: true,
        ),
      );

      await session.setActive(true);
      await Future.delayed(const Duration(milliseconds: 500));
      await session.setActive(false);

      print('✅ [Home] iOS microphone trigger completed');
    } catch (e) {
      print('⚠️ [Home] iOS microphone trigger failed: $e');
    }
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && _isBannerVisible) {
      setState(() {
        _isBannerVisible = false;
      });
      // Future.delayed(const Duration(milliseconds: 300), () {
      // if (!_isBannerVisible && mounted) {
      // }
      // });
    } else if (_scrollController.offset <= 50 && !_isBannerVisible) {
      setState(() {
        _isBannerVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            context.go(AppRoutes.home);
          },
          child: SvgPicture.asset('assets/icons/logo.svg', height: 24),
        ),
        actions: [
          // 권한 테스트 버튼 (임시)
          IconButton(
            icon: const Icon(Icons.security),
            onPressed: () async {
              // 권한 상태 확인
              final contactsStatus = await Permission.contacts.status;
              final microphoneStatus = await Permission.microphone.status;

              print('🔍 Current permission status:');
              print('📱 Contacts: $contactsStatus');
              print('🎤 Microphone: $microphoneStatus');

              // 권한 요청
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('권한 테스트'),
                  content: Text('연락처: $contactsStatus\n마이크: $microphoneStatus'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('취소'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);

                        // iOS에서 실제 마이크 접근 트리거
                        if (Platform.isIOS) {
                          await _triggerIOSMicrophoneRequest();
                        }

                        // 권한 요청
                        final Map<Permission, PermissionStatus> statuses =
                            await [
                              Permission.contacts,
                              Permission.microphone,
                            ].request();

                        print('📝 Permission request results:');
                        statuses.forEach((permission, status) {
                          print('$permission: $status');
                        });

                        ScaffoldMessenger.of(this.context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '연락처: ${statuses[Permission.contacts]}, 마이크: ${statuses[Permission.microphone]}',
                            ),
                          ),
                        );
                      },
                      child: Text('권한 요청'),
                    ),
                  ],
                ),
              );
            },
            tooltip: 'Permission Test',
          ),
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              context.push('/design-system');
            },
            tooltip: 'Design System',
          ),
        ],
      ),
      body: Container(
        color: AppColors.surface,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BannerCarousel(
                  isVisible: _isBannerVisible,
                  onClose: () {
                    setState(() {
                      _isBannerVisible = false;
                    });
                  },
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              top: _isBannerVisible ? 144 : 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  const SearchButton(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    color: AppColors.surface,
                    child: TabBar(
                      controller: _tabController,
                      labelColor: AppColors.textPrimary,
                      unselectedLabelColor: AppColors.textSecondary,
                      dividerColor: AppColors.divider,
                      dividerHeight: 1,
                      indicatorColor: AppColors.tabBarIndicator,
                      indicatorWeight: 1,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: AppTypography.labelLarge,
                      unselectedLabelStyle: AppTypography.labelLarge,
                      tabs: const [
                        Tab(text: '아시아'),
                        Tab(text: '유럽'),
                        Tab(text: '미주/호주'),
                        Tab(text: '복수국가'),
                      ],
                    ),
                  ),
                  // TabBarView 영역
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildProductGrid(ProductRegion.asia),
                        _buildProductGrid(ProductRegion.europe),
                        _buildProductGrid(ProductRegion.americasOceania),
                        _buildProductGrid(ProductRegion.multiple),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(ProductRegion region) {
    final state = ref.watch(productListViewModelProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('오류: ${state.error}'),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(productListViewModelProvider.notifier)
                    .loadAllProducts();
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    final filteredProducts = state.products
        .where((product) => product.region == region)
        .toList();

    return Container(
      color: AppColors.surface,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.heightLG,
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                final cardWidth =
                    (screenWidth - 14) / 2; // 2 columns with spacing

                return Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: filteredProducts.map((product) {
                    return SizedBox(
                      width: cardWidth,
                      child: ProductCard(
                        product: product,
                        onTap: () {
                          context.push('/product/${product.id}');
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
