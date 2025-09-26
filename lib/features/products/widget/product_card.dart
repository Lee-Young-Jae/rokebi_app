import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rokebi_app/core/constants/app_colors.dart';
import 'package:rokebi_app/core/constants/app_spacing.dart';
import 'package:rokebi_app/core/constants/app_typography.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
                if (product.badges.isNotEmpty)
                  Positioned(
                    child: Row(
                      children: product.badges
                          .map((badge) => _buildBadge(badge))
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
          AppSpacing.heightMD,
          Text(
            product.title,
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                product.price,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (product.originalPrice != null) ...[
                AppSpacing.widthXS,
                Text(
                  product.originalPrice!,
                  style: AppTypography.bodySmall.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              if (product.discountPercent != null) ...[
                AppSpacing.widthXS,
                Text(
                  product.discountPercent!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          AppSpacing.heightXXS,
          Text(
            product.purchaseCount,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(ProductBadge badge) {
    // 올데이+ 타입인 경우 SVG 아이콘 반환
    if (badge.type == ProductBadgeType.alldayPlus) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.productBadgeBlack,
          gradient: AppColors.primaryGradient,
        ),
        child: SvgPicture.asset('assets/icons/alldayPlusTag.svg'),
      );
    }

    // 타입별 색상 설정
    Color backgroundColor;
    Widget? icon;

    switch (badge.type) {
      case ProductBadgeType.popular:
        backgroundColor = AppColors.productBadgeRed;
        if (badge.hasIcon == true) {
          icon = const Icon(Icons.star, color: Colors.yellow, size: 16);
        }
        break;
      case ProductBadgeType.allday:
        backgroundColor = AppColors.productBadgeGreen;
        break;
      case ProductBadgeType.newProduct:
        backgroundColor = AppColors.productBadgeBlack;
        break;
      case ProductBadgeType.alldayPlus:
        backgroundColor = Colors.transparent;
        break;
      case ProductBadgeType.special:
        backgroundColor = AppColors.primary;
        break;
      case ProductBadgeType.sale:
        backgroundColor = AppColors.error;
        break;
    }

    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon, AppSpacing.widthXS],
            Text(
              badge.text,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
