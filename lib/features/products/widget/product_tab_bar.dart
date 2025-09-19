import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class ProductTabBar extends StatelessWidget {
  final List<String> tabs;
  final TabController? tabController;

  const ProductTabBar({
    super.key,
    required this.tabs,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    if (tabs.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TabBar(
        controller: tabController,
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textSecondary,
        dividerColor: AppColors.divider,
        dividerHeight: 1,
        indicatorColor: AppColors.tabBarIndicator,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: AppTypography.labelLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTypography.labelLarge,
        tabs: tabs.map((tab) => _buildTab(tab)).toList(),
      ),
    );
  }

  Widget _buildTab(String tabName) {
    if (tabName == '올데이+') {
      return Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/icons/iconAlldayPlus.svg', height: 16),
            const SizedBox(width: 4),
            Text(tabName),
          ],
        ),
      );
    }
    return Tab(text: tabName);
  }
}