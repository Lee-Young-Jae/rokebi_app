import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/product_model.dart';
import '../models/product_plan_model.dart';

part 'product_detail_state.freezed.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState({
    Product? product,
    @Default([]) List<String> availableTabs,
    @Default([]) List<ProductPlan> allPlans,
    @Default([]) List<ProductPlan> filteredPlans,
    @Default('전체') String selectedAlldayFilter,
    @Default('전체') String selectedDailyFilter,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingTab, // 탭 전환 시 별도 로딩 상태
    @Default('') String currentTabType,
    @Default({}) Map<String, List<ProductPlan>> tabCache, // 탭별 캐시
    String? error,
  }) = _ProductDetailState;
}