import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CircularCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final double size;

  const CircularCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onChanged != null;
    final effectiveActiveColor = activeColor ?? AppColors.primary;
    final effectiveCheckColor = checkColor ?? Colors.white;

    return GestureDetector(
      onTap: isEnabled
          ? () {
              onChanged?.call(!value);
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value ? effectiveActiveColor : Colors.transparent,
          border: Border.all(
            color: value
                ? effectiveActiveColor
                : (isEnabled
                      ? AppColors.divider
                      : AppColors.divider.withValues(alpha: 0.5)),
            width: 2,
          ),
        ),
        child: value
            ? Icon(Icons.check, size: size * 0.6, color: effectiveCheckColor)
            : null,
      ),
    );
  }
}
