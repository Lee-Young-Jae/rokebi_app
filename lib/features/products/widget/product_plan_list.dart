import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../models/product_plan_model.dart';
import '../models/product_model.dart';
import '../models/product_detail_state.dart';
import '../viewmodels/product_detail_view_model.dart';
import '../pages/plan_detail_page.dart';

class ProductPlanList extends StatelessWidget {
  final String tabType;
  final ProductDetailState state;
  final String productId;

  const ProductPlanList({
    super.key,
    required this.tabType,
    required this.state,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tabType == '올데이' || tabType == '올데이+') ...[
                AppSpacing.heightMD,
                _AlldayFilters(
                  tabType: tabType,
                  state: state,
                  productId: productId,
                ),
              ],
              if (tabType == '데일리') ...[
                AppSpacing.heightMD,
                _DailyFilters(state: state, productId: productId),
              ],
              Padding(
                padding: AppSpacing.screenPadding,
                child: Column(
                  children: [
                    AppSpacing.heightMD,
                    // isLoading이면 스켈레톤, 아니면 실제 데이터 표시
                    if (state.isLoading)
                      _SkeletonPlansContainer()
                    else
                      _PlansContainer(
                        plans: state.filteredPlans,
                        product: state.product!,
                      ),
                    AppSpacing.heightXXL,
                  ],
                ),
              ),
            ],
          ),
        ),
        // isLoadingTab이면 오버레이 로딩 인디케이터
        if (state.isLoadingTab)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.1),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}

class _AlldayFilters extends ConsumerWidget {
  final String tabType;
  final ProductDetailState state;
  final String productId;

  const _AlldayFilters({
    required this.tabType,
    required this.state,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ['전체', '단품', '더블팩'];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = state.selectedAlldayFilter == filter;

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              showCheckmark: false,
              onSelected: (selected) {
                ref
                    .read(productDetailViewModelProvider(productId).notifier)
                    .updateAlldayFilter(filter);
              },
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.primary,
              labelStyle: AppTypography.bodyMedium.copyWith(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.divider,
                width: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DailyFilters extends ConsumerWidget {
  final ProductDetailState state;
  final String productId;

  const _DailyFilters({required this.state, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ['전체', '500MB', '1GB', '2GB', '3GB', '4GB', '5GB'];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = state.selectedDailyFilter == filter;

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              showCheckmark: false,
              onSelected: (selected) {
                ref
                    .read(productDetailViewModelProvider(productId).notifier)
                    .updateDailyFilter(filter);
              },
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.primary,
              labelStyle: AppTypography.bodyMedium.copyWith(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.divider,
                width: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PlansContainer extends StatelessWidget {
  final List<ProductPlan> plans;
  final Product product;

  const _PlansContainer({required this.plans, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: plans.isEmpty
          ? _EmptyPlansWidget()
          : Column(
              children: plans.asMap().entries.map((entry) {
                final index = entry.key;
                final plan = entry.value;
                final isLast = index == plans.length - 1;

                return Column(
                  children: [
                    _PlanTile(plan: plan, product: product),
                    if (!isLast)
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: AppColors.divider,
                      ),
                  ],
                );
              }).toList(),
            ),
    );
  }
}

class _SkeletonPlansContainer extends StatelessWidget {
  const _SkeletonPlansContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        children: List.generate(
          3, // 3개의 스켈레톤 아이템 표시
          (index) => Column(
            children: [
              _SkeletonPlanTile(),
              if (index < 2)
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: AppColors.divider,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkeletonPlanTile extends StatelessWidget {
  const _SkeletonPlanTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.divider.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                AppSpacing.heightXS,
                Container(
                  width: 200,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.divider.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 80,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.divider.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              AppSpacing.heightXS,
              Container(
                width: 60,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.divider.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyPlansWidget extends StatelessWidget {
  const _EmptyPlansWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SVG 아이콘
          SvgPicture.asset(
            'assets/icons/iconNoCart.svg',
            width: 120,
            height: 120,
          ),
          AppSpacing.heightXL,
          Text(
            '해당 조건에 맞는 요금제가 없습니다',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.heightSM,
          Text(
            '다른 필터 조건을 선택해보세요',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  final ProductPlan plan;
  final Product product;

  const _PlanTile({required this.plan, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlanDetailPage(plan: plan, product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.title,
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryLight,
                      fontSize: 20,
                    ),
                  ),
                  AppSpacing.heightXXS,
                  Text(
                    plan.description,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  plan.price,
                  style: AppTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                if (plan.originalPrice != null) ...[
                  AppSpacing.heightXS,
                  Row(
                    children: [
                      Text(
                        plan.originalPrice!,
                        style: AppTypography.bodyMedium.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        plan.discountPercent!,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
