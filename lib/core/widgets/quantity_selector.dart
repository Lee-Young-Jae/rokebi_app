import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class QuantitySelector extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final double width;
  final double height;
  final ValueChanged<int> onChanged;
  final bool enabled;

  const QuantitySelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.minValue = 1,
    this.maxValue = 10,
    this.width = 80.0,
    this.height = 30.0,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = height;
    final canDecrease = enabled && value > minValue;
    final canIncrease = enabled && value < maxValue;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: enabled
              ? AppColors.divider
              : AppColors.divider.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 감소 버튼
          SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: IconButton(
              icon: const Icon(Icons.remove, size: 18),
              onPressed: canDecrease ? () => onChanged(value - 1) : null,
              color: canDecrease
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              padding: EdgeInsets.zero,
              splashRadius: buttonSize / 2,
            ),
          ),
          // 수량 표시 영역
          Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: AppColors.divider),
                right: BorderSide(color: AppColors.divider),
              ),
            ),
            child: Text(
              value.toString(),
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: enabled
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
            ),
          ),
          // 증가 버튼
          SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: IconButton(
              icon: const Icon(Icons.add, size: 18),
              onPressed: canIncrease ? () => onChanged(value + 1) : null,
              color: canIncrease
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              padding: EdgeInsets.zero,
              splashRadius: buttonSize / 2,
            ),
          ),
        ],
      ),
    );
  }
}
