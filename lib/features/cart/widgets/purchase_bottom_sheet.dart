import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/quantity_selector.dart';
import '../../products/models/product_model.dart';
import '../../products/models/plan_model.dart';
import '../viewmodels/cart_view_model.dart';

class PurchaseBottomSheet extends ConsumerStatefulWidget {
  final Product product;
  final Plan plan;

  const PurchaseBottomSheet({
    super.key,
    required this.product,
    required this.plan,
  });

  static Future<void> show(BuildContext context, Product product, Plan plan) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PurchaseBottomSheet(product: product, plan: plan),
    );
  }

  @override
  ConsumerState<PurchaseBottomSheet> createState() =>
      _PurchaseBottomSheetState();
}

class _PurchaseBottomSheetState extends ConsumerState<PurchaseBottomSheet> {
  int quantity = 1;

  void _updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  double get totalPrice => widget.plan.finalPrice.toDouble() * quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 수량 선택
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surfaceVariant),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '수량',
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  QuantitySelector(
                    value: quantity,
                    onChanged: _updateQuantity,
                    width: 80,
                    height: 30,
                    minValue: 1,
                    maxValue: 10,
                  ),
                ],
              ),
            ),

            AppSpacing.heightXL,

            // 총 금액
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 상품금액',
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            AppSpacing.heightXXL,

            // 버튼들
            Row(
              children: [
                // 장바구니 담기 버튼
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      // 장바구니에 추가
                      await ref
                          .read(cartViewModelProvider.notifier)
                          .addToCart(
                            product: widget.product,
                            plan: widget.plan,
                            quantity: quantity,
                          );

                      if (context.mounted) {
                        // 바텀시트 닫기
                        context.pop();

                        // 스낵바 표시
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('장바구니에 담겼습니다'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    child: Text(
                      '카트에 담기',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                AppSpacing.widthMD,
                // 바로 구매하기 버튼
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // 장바구니에 추가 후 장바구니 페이지로 이동

                      print("widget.product: ${widget.product}");
                      print("widget.plan: ${widget.plan}");
                      print("quantity: ${quantity}");

                      await ref
                          .read(cartViewModelProvider.notifier)
                          .addToCart(
                            product: widget.product,
                            plan: widget.plan,
                            quantity: quantity,
                          );

                      if (context.mounted) {
                        context.pop(); // 바텀시트 닫기
                        context.go('/cart'); // 장바구니 페이지로 이동
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      '바로 구매하기',
                      style: AppTypography.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
