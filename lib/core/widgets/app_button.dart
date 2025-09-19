import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/app_radius.dart';

enum AppButtonType { primary, secondary, outlined, text, danger }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ButtonStyle? customStyle;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.customStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _getHeight(),
      child: icon != null
          ? _buildIconButton(isDisabled)
          : _buildRegularButton(isDisabled),
    );
  }

  Widget _buildIconButton(bool isDisabled) {
    if (type == AppButtonType.text) {
      return TextButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: isLoading ? _buildLoader() : icon!,
        label: Text(text),
        style: _getButtonStyle(),
      );
    } else if (type == AppButtonType.outlined) {
      return OutlinedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: isLoading ? _buildLoader() : icon!,
        label: Text(text),
        style: _getButtonStyle(),
      );
    } else {
      return ElevatedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: isLoading ? _buildLoader() : icon!,
        label: Text(text),
        style: _getButtonStyle(),
      );
    }
  }

  Widget _buildRegularButton(bool isDisabled) {
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null && !isLoading) ...[
          prefixIcon!,
          AppSpacing.widthSM,
        ],
        if (isLoading) ...[_buildLoader(), AppSpacing.widthSM],
        Flexible(
          child: Text(
            text,
            style: _getTextStyle(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (suffixIcon != null && !isLoading) ...[
          AppSpacing.widthSM,
          suffixIcon!,
        ],
      ],
    );

    if (type == AppButtonType.text) {
      return TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: _getButtonStyle(),
        child: content,
      );
    } else if (type == AppButtonType.outlined) {
      return OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: _getButtonStyle(),
        child: content,
      );
    } else {
      return ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: _getButtonStyle(),
        child: content,
      );
    }
  }

  Widget _buildLoader() {
    return SizedBox(
      width: _getLoaderSize(),
      height: _getLoaderSize(),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(_getLoaderColor()),
      ),
    );
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 48;
      case AppButtonSize.large:
        return 56;
    }
  }

  double _getLoaderSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  Color _getLoaderColor() {
    if (type == AppButtonType.primary || type == AppButtonType.danger) {
      return AppColors.textOnPrimary;
    }
    return AppColors.primary;
  }

  TextStyle _getTextStyle() {
    TextStyle baseStyle;
    switch (size) {
      case AppButtonSize.small:
        baseStyle = AppTypography.labelMedium;
        break;
      case AppButtonSize.medium:
        baseStyle = AppTypography.button;
        break;
      case AppButtonSize.large:
        baseStyle = AppTypography.labelLarge.copyWith(fontSize: 16);
        break;
    }

    Color textColor;
    switch (type) {
      case AppButtonType.primary:
        textColor = AppColors.textOnPrimary;
        break;
      case AppButtonType.danger:
        textColor = AppColors.textOnPrimary;
        break;
      case AppButtonType.secondary:
        textColor = AppColors.primary;
        break;
      case AppButtonType.outlined:
        textColor = Colors.black.withValues(alpha: 0.85);
        break;
      case AppButtonType.text:
        textColor = AppColors.primary;
        break;
    }

    return baseStyle.copyWith(color: textColor);
  }

  ButtonStyle _getButtonStyle() {
    final baseStyle = _getBaseButtonStyle();
    return customStyle != null ? baseStyle.merge(customStyle!) : baseStyle;
  }

  ButtonStyle _getBaseButtonStyle() {
    final EdgeInsetsGeometry padding;
    switch (size) {
      case AppButtonSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        break;
      case AppButtonSize.medium:
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
        break;
      case AppButtonSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
        break;
    }

    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          padding: padding,
          shape: AppRadius.shapeMD,
        );
      case AppButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.textOnPrimary,
          padding: padding,
          shape: AppRadius.shapeMD,
        );
      case AppButtonType.danger:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          foregroundColor: AppColors.textOnPrimary,
          padding: padding,
          shape: AppRadius.shapeMD,
        );
      case AppButtonType.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: Colors.black.withValues(alpha: 0.85),
          side: const BorderSide(color: Color(0xFFD8D8D8), width: 1.5),
          padding: padding,
          shape: AppRadius.shapeMD,
          elevation: 0,
          shadowColor: Colors.black.withValues(alpha: 0.015),
        ).copyWith(elevation: WidgetStateProperty.all(2));
      case AppButtonType.text:
        return TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: padding,
          shape: AppRadius.shapeMD,
        );
    }
  }
}
