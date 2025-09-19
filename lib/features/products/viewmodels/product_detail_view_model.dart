import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../models/product_plan_model.dart';
import '../models/product_detail_state.dart';
import '../repositories/product_repository.dart';
import '../repositories/product_plan_repository.dart';

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
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<List<String>> _setupTabs(Product product) async {
    try {
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
    } catch (e) {
      // API 오류 시 제품 배지 기반 fallback
      final tabs = <String>[];

      bool hasAllday = product.badges.any(
        (badge) => badge.type == ProductBadgeType.allday,
      );
      bool hasAlldayPlus = product.badges.any(
        (badge) => badge.type == ProductBadgeType.alldayPlus,
      );

      if (hasAllday) {
        tabs.add('올데이');
      }
      if (hasAlldayPlus) {
        tabs.add('올데이+');
      }

      // 기본적으로 데일리와 종량제는 항상 포함
      tabs.add('데일리');
      tabs.add('종량제');

      return tabs;
    }
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
    } catch (e) {
      // API 오류 시 더미 데이터로 fallback
      List<ProductPlan> fallbackPlans;
      switch (tabType) {
        case '올데이':
          fallbackPlans = _getAlldayPlans();
          break;
        case '올데이+':
          fallbackPlans = _getAlldayPlusPlans();
          break;
        case '데일리':
          fallbackPlans = _getDailyPlans();
          break;
        case '종량제':
          fallbackPlans = _getPayAsYouGoPlans();
          break;
        default:
          fallbackPlans = [];
      }

      // 캐시 업데이트
      final updatedCache = Map<String, List<ProductPlan>>.from(state.tabCache);
      updatedCache[cacheKey] = fallbackPlans;

      state = state.copyWith(
        allPlans: fallbackPlans,
        currentTabType: tabType,
        isLoading: false,
        isLoadingTab: false,
        tabCache: updatedCache,
      );
      _applyFilters(tabType);
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
      // API에서 필터링된 데이터를 직접 가져오기
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
    } catch (e) {
      // API 오류 시 클라이언트 사이드 필터링으로 fallback
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

  // API 오류 시 fallback용 더미 데이터 메서드들
  List<ProductPlan> _getAlldayPlans() {
    final productId = state.product?.id ?? '1';
    return [
      ProductPlan(
        id: 'fallback_allday_1',
        productId: productId,
        title: '3일',
        description: '일 데이터 제한 없이 완전 무제한',
        price: '8,600원',
        originalPrice: '9,900원',
        discountPercent: '13%',
        planType: PlanType.allday,
        subType: '단품',
        duration: 3,
        isUnlimited: true,
        features: ['데이터 무제한', '통화 가능', '문자 발송 가능'],
      ),
      ProductPlan(
        id: 'fallback_allday_2',
        productId: productId,
        title: '7일',
        description: '일 데이터 제한 없이 완전 무제한',
        price: '19,000원',
        originalPrice: '29,900원',
        discountPercent: '36%',
        planType: PlanType.allday,
        subType: '단품',
        duration: 7,
        isUnlimited: true,
        features: ['데이터 무제한', '통화 가능', '문자 발송 가능'],
      ),
    ];
  }

  List<ProductPlan> _getAlldayPlusPlans() {
    final productId = state.product?.id ?? '1';
    return [
      ProductPlan(
        id: 'fallback_alldayplus_1',
        productId: productId,
        title: '3일',
        description: '3일 프리미엄 데이터 무제한',
        price: '7,500원',
        originalPrice: '8,400원',
        discountPercent: '10%',
        planType: PlanType.alldayplus,
        subType: '단품',
        duration: 3,
        isUnlimited: true,
        features: ['프리미엄 데이터 무제한', '통화 가능', '문자 발송 가능'],
      ),
    ];
  }

  List<ProductPlan> _getDailyPlans() {
    final productId = state.product?.id ?? '1';
    return [
      ProductPlan(
        id: 'fallback_daily_1',
        productId: productId,
        title: '500MB 1일',
        description: '1일 500MB 고속 데이터',
        price: '490원',
        planType: PlanType.daily,
        volume: '500MB',
        duration: 1,
        isUnlimited: false,
        features: ['500MB 고속 데이터', '통화 가능'],
      ),
      ProductPlan(
        id: 'fallback_daily_2',
        productId: productId,
        title: '1GB 3일',
        description: '3일 1GB 고속 데이터',
        price: '1,890원',
        planType: PlanType.daily,
        volume: '1GB',
        duration: 3,
        isUnlimited: false,
        features: ['1GB 고속 데이터', '통화 가능'],
      ),
    ];
  }

  List<ProductPlan> _getPayAsYouGoPlans() {
    final productId = state.product?.id ?? '1';
    return [
      ProductPlan(
        id: 'fallback_payasyougo_1',
        productId: productId,
        title: '100MB LINE Mobile',
        description: '소량 사용자를 위한 경제적 선택',
        price: '290원',
        planType: PlanType.payasyougo,
        volume: '100MB',
        carrier: 'LINE Mobile',
        isUnlimited: false,
        features: ['100MB 데이터', '통화 불가'],
      ),
      ProductPlan(
        id: 'fallback_payasyougo_2',
        productId: productId,
        title: '1GB UQ Mobile',
        description: '단기 여행에 적합한 선택',
        price: '1,590원',
        planType: PlanType.payasyougo,
        volume: '1GB',
        carrier: 'UQ Mobile',
        isUnlimited: false,
        features: ['1GB 데이터', '통화 가능'],
      ),
    ];
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
