import 'package:flutter/material.dart';
import 'package:rokebi_app/core/constants/app_shadows.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/routes/app_routes.dart';

class SearchButton extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;

  const SearchButton({super.key, this.hintText = '어디로 여행을 떠날까요?', this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: InkWell(
        onTap: onTap ?? () => Navigator.pushNamed(context, AppRoutes.search),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border, width: 1),
            boxShadow: AppShadows.cardShadow,
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: AppColors.textPrimary, size: 24),
              const SizedBox(width: 12),
              Text(
                hintText,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
