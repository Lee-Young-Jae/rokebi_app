import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        title: SvgPicture.asset('assets/icons/logo.svg', height: 24),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.designSystem);
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
                ref.read(productListViewModelProvider.notifier).loadAllProducts();
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.productDetail,
                      arguments: product.id,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
