import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rokebi_app/core/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../viewmodels/cart_view_model.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartViewModelProvider);
    final cartViewModel = ref.read(cartViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: cart.items.isEmpty
          ? null
          : AppBar(
              backgroundColor: AppColors.surface,
              title: Text(
                '카트',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => {
                  // 뒤로가기 스택이 있다면
                  if (context.canPop())
                    {context.pop()}
                  else
                    {context.go(AppRoutes.home)},
                  // 없다면 home
                },
              ),
            ),
      body: cart.items.isEmpty
          ? _buildEmptyCart(context)
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: AppSpacing.screenPadding,
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: AppSpacing.paddingMD,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 상품 이미지
                                  if (item.productImageUrl != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        item.productImageUrl!,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                width: 80,
                                                height: 80,
                                                color: AppColors.divider,
                                                child: const Icon(
                                                  Icons.image_not_supported,
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  AppSpacing.widthMD,
                                  // 상품 정보
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.productName,
                                          style: AppTypography.bodyLarge
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        AppSpacing.heightXS,
                                        Text(
                                          item.planName,
                                          style: AppTypography.bodyMedium
                                              .copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                        AppSpacing.heightSM,
                                        Text(
                                          '${item.unitPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                          style: AppTypography.bodyMedium
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 삭제 버튼
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () async {
                                      await cartViewModel.removeFromCart(
                                        item.id,
                                      );
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('상품이 장바구니에서 삭제되었습니다'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              AppSpacing.heightMD,
                              // 수량 조절
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '수량',
                                    style: AppTypography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.divider,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          constraints: const BoxConstraints(
                                            minWidth: 32,
                                            minHeight: 32,
                                          ),
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            cartViewModel.updateQuantity(
                                              item.id,
                                              item.quantity - 1,
                                            );
                                          },
                                        ),
                                        Container(
                                          constraints: const BoxConstraints(
                                            minWidth: 30,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            item.quantity.toString(),
                                            style: AppTypography.bodyMedium,
                                          ),
                                        ),
                                        IconButton(
                                          constraints: const BoxConstraints(
                                            minWidth: 32,
                                            minHeight: 32,
                                          ),
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(Icons.add, size: 18),
                                          onPressed: () {
                                            cartViewModel.updateQuantity(
                                              item.id,
                                              item.quantity + 1,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.heightSM,
                              // 소계
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('소계', style: AppTypography.bodyMedium),
                                  Text(
                                    '${item.totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                    style: AppTypography.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // 하단 결제 섹션
                Container(
                  padding: AppSpacing.paddingLG,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '총 결제금액',
                              style: AppTypography.titleMedium.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${cart.totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                              style: AppTypography.titleLarge.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.heightLG,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('결제 기능은 준비중입니다')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              '결제하기',
                              style: AppTypography.bodyLarge.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // svg
            SvgPicture.asset(
              'assets/icons/iconNoCart.svg',
              width: 140,
              height: 140,
            ),
            AppSpacing.heightXL,
            Text(
              '카트가 비어있습니다',
              style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
            ),
            Text(
              '로밍도깨비와 즐거운 여행을 계획해 보세요!',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
