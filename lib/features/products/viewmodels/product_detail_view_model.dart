import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../models/product_plan_model.dart';
import '../models/product_detail_state.dart';
import '../repositories/product_repository.dart';
import '../repositories/product_plan_repository.dart';
import '../../../core/errors/global_error_handler.dart';

class ProductDetailViewModel extends StateNotifier<ProductDetailState> {
  final ProductRepository _productRepository;
  final ProductPlanRepository _planRepository;

  ProductDetailViewModel(this._productRepository, this._planRepository)
    : super(const ProductDetailState());

  Future<void> loadProduct(String productId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final product = await _productRepository.getProductById(productId);

      // 탭 설정
      final tabs = await _setupTabs(product);

      state = state.copyWith(
        product: product,
        availableTabs: tabs,
        isLoading: false,
      );

      // 첫 번째 탭의 플랜들을 로드
      if (tabs.isNotEmpty) {
        loadPlansForTab(tabs.first);
      }
    } catch (e, stackTrace) {
      final appError = GlobalErrorHandler.handleError(e, stackTrace);
      state = state.copyWith(error: appError.toString(), isLoading: false);
    }
  }

  Future<List<String>> _setupTabs(Product product) async {
    // 요금제 타입들을 조회
    final plansGrouped = await _planRepository.getPlansGroupedByPeriod(
      product.id,
    );

    // planType 키를 한글 표시명으로 변환
    final availableDisplayNames = <String>[];
    for (final planTypeKey in plansGrouped.keys) {
      final planType = PlanType.values.firstWhere(
        (type) => type.name == planTypeKey,
        orElse: () => PlanType.allday, // 기본값
      );
      availableDisplayNames.add(planType.displayName);
    }

    return availableDisplayNames;
  }

  Future<void> loadPlansForTab(String tabType) async {
    if (state.product == null) return;

    // 캐시 확인
    final cacheKey =
        '$tabType-${state.selectedAlldayFilter}-${state.selectedDailyFilter}';
    if (state.tabCache.containsKey(cacheKey)) {
      // 캐시된 데이터가 있으면 즉시 보여주기
      state = state.copyWith(
        filteredPlans: state.tabCache[cacheKey]!,
        currentTabType: tabType,
        isLoadingTab: false,
      );
      return;
    }

    // 첫 로딩이면 isLoading, 이후 탭 전환이면 isLoadingTab 사용
    final isFirstLoad = state.filteredPlans.isEmpty;
    state = state.copyWith(
      isLoading: isFirstLoad,
      isLoadingTab: !isFirstLoad, // 이전 데이터 유지하면서 로딩
    );

    try {
      // 탭 타입을 PlanType enum으로 변환
      PlanType? planType;
      switch (tabType) {
        case '올데이':
          planType = PlanType.allday;
          break;
        case '올데이+':
          planType = PlanType.alldayplus;
          break;
        case '데일리':
          planType = PlanType.daily;
          break;
        case '종량제':
          planType = PlanType.payasyougo;
          break;
      }

      if (planType != null) {
        final allPlans = await _planRepository.getPlansByProductId(
          state.product!.id,
        );
        final plans = allPlans.where((p) => p.planType == planType).toList();

        // 캐시 업데이트
        final updatedCache = Map<String, List<ProductPlan>>.from(
          state.tabCache,
        );
        updatedCache[cacheKey] = plans;

        state = state.copyWith(
          allPlans: plans,
          currentTabType: tabType,
          isLoading: false,
          isLoadingTab: false,
          tabCache: updatedCache,
        );
        _applyFilters(tabType);
      } else {
        state = state.copyWith(isLoading: false, isLoadingTab: false);
      }
    } catch (e, stackTrace) {
      final appError = GlobalErrorHandler.handleError(e, stackTrace);
      state = state.copyWith(
        error: appError.toString(),
        isLoading: false,
        isLoadingTab: false,
      );
    }
  }

  Future<void> updateAlldayFilter(String filter) async {
    state = state.copyWith(selectedAlldayFilter: filter);
    await _applyFilters(state.currentTabType);
  }

  Future<void> updateDailyFilter(String filter) async {
    state = state.copyWith(selectedDailyFilter: filter);
    await _applyFilters(state.currentTabType);
  }

  Future<void> _applyFilters(String tabType) async {
    if (state.product == null) return;

    try {
      PlanType? planType;
      String? subType;
      String? volume;

      switch (tabType) {
        case '올데이':
          planType = PlanType.allday;
          if (state.selectedAlldayFilter != '전체') {
            subType = state.selectedAlldayFilter;
          }
          break;
        case '올데이+':
          planType = PlanType.alldayplus;
          if (state.selectedAlldayFilter != '전체') {
            subType = state.selectedAlldayFilter;
          }
          break;
        case '데일리':
          planType = PlanType.daily;
          if (state.selectedDailyFilter != '전체') {
            volume = state.selectedDailyFilter;
          }
          break;
        case '종량제':
          planType = PlanType.payasyougo;
          break;
      }

      if (planType != null) {
        final allPlans = await _planRepository.getPlansByProductId(
          state.product!.id,
        );

        var filteredPlans = allPlans
            .where((p) => p.planType == planType)
            .toList();
        if (subType != null) {
          filteredPlans = filteredPlans
              .where((p) => p.subType == subType)
              .toList();
        }
        if (volume != null) {
          filteredPlans = filteredPlans
              .where((p) => p.volume == volume)
              .toList();
        }

        state = state.copyWith(filteredPlans: filteredPlans);
      }
    } catch (e, stackTrace) {
      GlobalErrorHandler.handleError(e, stackTrace);
      // 필터링에서 실패 시 전체 플랜 표시
      List<ProductPlan> filtered = List.from(state.allPlans);

      if (tabType == '올데이' || tabType == '올데이+') {
        if (state.selectedAlldayFilter != '전체') {
          filtered = filtered
              .where((plan) => plan.subType == state.selectedAlldayFilter)
              .toList();
        }
      } else if (tabType == '데일리') {
        if (state.selectedDailyFilter != '전체') {
          filtered = filtered
              .where((plan) => plan.volume == state.selectedDailyFilter)
              .toList();
        }
      }

      state = state.copyWith(filteredPlans: filtered);
    }
  }
}

// Provider 정의
final productDetailViewModelProvider =
    StateNotifierProvider.family<
      ProductDetailViewModel,
      ProductDetailState,
      String
    >((ref, productId) {
      final productRepository = ref.watch(productRepositoryProvider);
      final planRepository = ref.watch(productPlanRepositoryProvider);
      final viewModel = ProductDetailViewModel(
        productRepository,
        planRepository,
      );
      viewModel.loadProduct(productId);
      return viewModel;
    });
