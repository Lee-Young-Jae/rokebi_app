import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_radius.dart';

enum AppCardType { elevated, outlined, filled }

class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardType type;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.type = AppCardType.elevated,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final cardChild = Padding(
      padding: padding ?? AppSpacing.cardPadding,
      child: child,
    );

    final cardContent = Material(
      color: backgroundColor ?? _getBackgroundColor(),
      borderRadius: borderRadius ?? AppRadius.borderRadiusMD,
      elevation: _getElevation(),
      shadowColor: AppColors.shadow,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? AppRadius.borderRadiusMD,
        child: Container(decoration: _getDecoration(), child: cardChild),
      ),
    );

    if (margin != null) {
      return Padding(padding: margin!, child: cardContent);
    }

    return cardContent;
  }

  Color _getBackgroundColor() {
    switch (type) {
      case AppCardType.elevated:
      case AppCardType.outlined:
        return AppColors.surface;
      case AppCardType.filled:
        return AppColors.surfaceVariant;
    }
  }

  double _getElevation() {
    if (elevation != null) return elevation!;

    switch (type) {
      case AppCardType.elevated:
        return 2;
      case AppCardType.outlined:
      case AppCardType.filled:
        return 0;
    }
  }

  BoxDecoration? _getDecoration() {
    switch (type) {
      case AppCardType.elevated:
      case AppCardType.filled:
        return null;
      case AppCardType.outlined:
        return BoxDecoration(
          borderRadius: borderRadius ?? AppRadius.borderRadiusMD,
          border: border ?? Border.all(color: AppColors.borderLight, width: 1),
        );
    }
  }
}

class AppProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String? originalPrice;
  final String? discount;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool isOutOfStock;

  const AppProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    this.discount,
    this.onTap,
    this.onAddToCart,
    this.isOutOfStock = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      type: AppCardType.elevated,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: AppColors.surfaceVariant,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: AppColors.textHint,
                    ),
                  ),
                ),
              ),
              if (discount != null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(color: AppColors.error),
                    child: Text(
                      discount!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (isOutOfStock)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                    ),
                    child: const Center(
                      child: Text(
                        '품절',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: AppSpacing.paddingMD,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.heightSM,
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (originalPrice != null) ...[
                      AppSpacing.widthSM,
                      Text(
                        originalPrice!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textHint,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
