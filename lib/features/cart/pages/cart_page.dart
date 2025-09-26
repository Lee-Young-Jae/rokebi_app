import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rokebi_app/core/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/circular_checkbox.dart';
import '../../../core/widgets/quantity_selector.dart';
import '../viewmodels/cart_view_model.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartViewModelProvider);

    // 빈 카트면 빈 카트 화면, 아이템 있으면 카트 내용 표시
    return cart.items.isEmpty ? _EmptyCartPage() : _CartPageContent();
  }
}

// 빈 카트 페이지
class _EmptyCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
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
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
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
      ),
    );
  }
}

// 네비게이션이 없는 카트 내용 페이지
class _CartPageContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartViewModelProvider);
    final cartViewModel = ref.read(cartViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(
          '카트',
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w700),
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
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            // 카트 아이템들
            ...cart.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == cart.items.length - 1;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: isLast
                      ? const Border(
                          bottom: BorderSide(
                            color: AppColors.textPrimary,
                            width: 1.0,
                          ),
                        )
                      : const Border(
                          bottom: BorderSide(
                            color: AppColors.divider,
                            width: 1.0,
                          ),
                        ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacing.heightSM,
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 원형 체크박스
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: CircularCheckbox(
                                value: item.isSelected,
                                onChanged: (_) =>
                                    cartViewModel.toggleItemSelection(item.id),
                                activeColor: AppColors.primary,
                                size: 24,
                              ),
                            ),
                          ),
                          // 상품 이미지
                          if (item.productImageUrl != null)
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                item.productImageUrl!,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${item.productName} ${item.planType} ${item.planName}",
                                  style: AppTypography.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                AppSpacing.heightXS,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item.unitPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                      style: AppTypography.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    QuantitySelector(
                                      value: item.quantity,
                                      onChanged: (newQuantity) {
                                        cartViewModel.updateQuantity(
                                          item.id,
                                          newQuantity,
                                        );
                                      },
                                      width: 36,
                                      height: 32,
                                      minValue: 1,
                                      maxValue: 10,
                                    ),
                                  ],
                                ),
                                AppSpacing.heightSM,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item.totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                      style: AppTypography.titleLarge.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    AppSpacing.widthSM,
                                    GestureDetector(
                                      onTap: () async {
                                        await cartViewModel.removeFromCart(
                                          item.id,
                                        );
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                '상품이 장바구니에서 삭제되었습니다',
                                              ),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.divider,
                                            width: 1,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.delete_outline_rounded,
                                            size: 20,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.heightXXL,
                  ],
                ),
              );
            }),

            // 주문 요약 섹션
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: AppSpacing.paddingMD,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '주문 상품 수',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '총 ${cartViewModel.selectedItemCount}개',
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.heightMD,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '주문 상품 금액',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${cartViewModel.selectedTotalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                        style: AppTypography.titleLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.heightMD,
                  Text(
                    '쿠폰 및 로깨비캐시 적용에 따라 최종 결제 금액이 결정됩니다.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // 하단 결제 섹션을 bottomNavigationBar로 이동
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
            horizontal: BorderSide(color: AppColors.divider, width: 1),
          ),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: AppSpacing.paddingLG,
                    child: Row(
                      children: [
                        Text(
                          '금액: ',
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${cartViewModel.selectedTotalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('결제 기능은 준비중입니다')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        '총 ${cartViewModel.selectedItemCount}개 구매하기',
                        style: AppTypography.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
