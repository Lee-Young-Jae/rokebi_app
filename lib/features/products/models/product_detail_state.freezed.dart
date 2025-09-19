// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductDetailState {
  Product? get product => throw _privateConstructorUsedError;
  List<String> get availableTabs => throw _privateConstructorUsedError;
  List<ProductPlan> get allPlans => throw _privateConstructorUsedError;
  List<ProductPlan> get filteredPlans => throw _privateConstructorUsedError;
  String get selectedAlldayFilter => throw _privateConstructorUsedError;
  String get selectedDailyFilter => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingTab =>
      throw _privateConstructorUsedError; // 탭 전환 시 별도 로딩 상태
  String get currentTabType => throw _privateConstructorUsedError;
  Map<String, List<ProductPlan>> get tabCache =>
      throw _privateConstructorUsedError; // 탭별 캐시
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductDetailStateCopyWith<ProductDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailStateCopyWith(
    ProductDetailState value,
    $Res Function(ProductDetailState) then,
  ) = _$ProductDetailStateCopyWithImpl<$Res, ProductDetailState>;
  @useResult
  $Res call({
    Product? product,
    List<String> availableTabs,
    List<ProductPlan> allPlans,
    List<ProductPlan> filteredPlans,
    String selectedAlldayFilter,
    String selectedDailyFilter,
    bool isLoading,
    bool isLoadingTab,
    String currentTabType,
    Map<String, List<ProductPlan>> tabCache,
    String? error,
  });

  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$ProductDetailStateCopyWithImpl<$Res, $Val extends ProductDetailState>
    implements $ProductDetailStateCopyWith<$Res> {
  _$ProductDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
    Object? availableTabs = null,
    Object? allPlans = null,
    Object? filteredPlans = null,
    Object? selectedAlldayFilter = null,
    Object? selectedDailyFilter = null,
    Object? isLoading = null,
    Object? isLoadingTab = null,
    Object? currentTabType = null,
    Object? tabCache = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            product: freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as Product?,
            availableTabs: null == availableTabs
                ? _value.availableTabs
                : availableTabs // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            allPlans: null == allPlans
                ? _value.allPlans
                : allPlans // ignore: cast_nullable_to_non_nullable
                      as List<ProductPlan>,
            filteredPlans: null == filteredPlans
                ? _value.filteredPlans
                : filteredPlans // ignore: cast_nullable_to_non_nullable
                      as List<ProductPlan>,
            selectedAlldayFilter: null == selectedAlldayFilter
                ? _value.selectedAlldayFilter
                : selectedAlldayFilter // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedDailyFilter: null == selectedDailyFilter
                ? _value.selectedDailyFilter
                : selectedDailyFilter // ignore: cast_nullable_to_non_nullable
                      as String,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingTab: null == isLoadingTab
                ? _value.isLoadingTab
                : isLoadingTab // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentTabType: null == currentTabType
                ? _value.currentTabType
                : currentTabType // ignore: cast_nullable_to_non_nullable
                      as String,
            tabCache: null == tabCache
                ? _value.tabCache
                : tabCache // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<ProductPlan>>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductDetailStateImplCopyWith<$Res>
    implements $ProductDetailStateCopyWith<$Res> {
  factory _$$ProductDetailStateImplCopyWith(
    _$ProductDetailStateImpl value,
    $Res Function(_$ProductDetailStateImpl) then,
  ) = __$$ProductDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Product? product,
    List<String> availableTabs,
    List<ProductPlan> allPlans,
    List<ProductPlan> filteredPlans,
    String selectedAlldayFilter,
    String selectedDailyFilter,
    bool isLoading,
    bool isLoadingTab,
    String currentTabType,
    Map<String, List<ProductPlan>> tabCache,
    String? error,
  });

  @override
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$ProductDetailStateImplCopyWithImpl<$Res>
    extends _$ProductDetailStateCopyWithImpl<$Res, _$ProductDetailStateImpl>
    implements _$$ProductDetailStateImplCopyWith<$Res> {
  __$$ProductDetailStateImplCopyWithImpl(
    _$ProductDetailStateImpl _value,
    $Res Function(_$ProductDetailStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
    Object? availableTabs = null,
    Object? allPlans = null,
    Object? filteredPlans = null,
    Object? selectedAlldayFilter = null,
    Object? selectedDailyFilter = null,
    Object? isLoading = null,
    Object? isLoadingTab = null,
    Object? currentTabType = null,
    Object? tabCache = null,
    Object? error = freezed,
  }) {
    return _then(
      _$ProductDetailStateImpl(
        product: freezed == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as Product?,
        availableTabs: null == availableTabs
            ? _value._availableTabs
            : availableTabs // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        allPlans: null == allPlans
            ? _value._allPlans
            : allPlans // ignore: cast_nullable_to_non_nullable
                  as List<ProductPlan>,
        filteredPlans: null == filteredPlans
            ? _value._filteredPlans
            : filteredPlans // ignore: cast_nullable_to_non_nullable
                  as List<ProductPlan>,
        selectedAlldayFilter: null == selectedAlldayFilter
            ? _value.selectedAlldayFilter
            : selectedAlldayFilter // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedDailyFilter: null == selectedDailyFilter
            ? _value.selectedDailyFilter
            : selectedDailyFilter // ignore: cast_nullable_to_non_nullable
                  as String,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingTab: null == isLoadingTab
            ? _value.isLoadingTab
            : isLoadingTab // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentTabType: null == currentTabType
            ? _value.currentTabType
            : currentTabType // ignore: cast_nullable_to_non_nullable
                  as String,
        tabCache: null == tabCache
            ? _value._tabCache
            : tabCache // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<ProductPlan>>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ProductDetailStateImpl implements _ProductDetailState {
  const _$ProductDetailStateImpl({
    this.product,
    final List<String> availableTabs = const [],
    final List<ProductPlan> allPlans = const [],
    final List<ProductPlan> filteredPlans = const [],
    this.selectedAlldayFilter = '전체',
    this.selectedDailyFilter = '전체',
    this.isLoading = false,
    this.isLoadingTab = false,
    this.currentTabType = '',
    final Map<String, List<ProductPlan>> tabCache = const {},
    this.error,
  }) : _availableTabs = availableTabs,
       _allPlans = allPlans,
       _filteredPlans = filteredPlans,
       _tabCache = tabCache;

  @override
  final Product? product;
  final List<String> _availableTabs;
  @override
  @JsonKey()
  List<String> get availableTabs {
    if (_availableTabs is EqualUnmodifiableListView) return _availableTabs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableTabs);
  }

  final List<ProductPlan> _allPlans;
  @override
  @JsonKey()
  List<ProductPlan> get allPlans {
    if (_allPlans is EqualUnmodifiableListView) return _allPlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allPlans);
  }

  final List<ProductPlan> _filteredPlans;
  @override
  @JsonKey()
  List<ProductPlan> get filteredPlans {
    if (_filteredPlans is EqualUnmodifiableListView) return _filteredPlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredPlans);
  }

  @override
  @JsonKey()
  final String selectedAlldayFilter;
  @override
  @JsonKey()
  final String selectedDailyFilter;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingTab;
  // 탭 전환 시 별도 로딩 상태
  @override
  @JsonKey()
  final String currentTabType;
  final Map<String, List<ProductPlan>> _tabCache;
  @override
  @JsonKey()
  Map<String, List<ProductPlan>> get tabCache {
    if (_tabCache is EqualUnmodifiableMapView) return _tabCache;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tabCache);
  }

  // 탭별 캐시
  @override
  final String? error;

  @override
  String toString() {
    return 'ProductDetailState(product: $product, availableTabs: $availableTabs, allPlans: $allPlans, filteredPlans: $filteredPlans, selectedAlldayFilter: $selectedAlldayFilter, selectedDailyFilter: $selectedDailyFilter, isLoading: $isLoading, isLoadingTab: $isLoadingTab, currentTabType: $currentTabType, tabCache: $tabCache, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDetailStateImpl &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality().equals(
              other._availableTabs,
              _availableTabs,
            ) &&
            const DeepCollectionEquality().equals(other._allPlans, _allPlans) &&
            const DeepCollectionEquality().equals(
              other._filteredPlans,
              _filteredPlans,
            ) &&
            (identical(other.selectedAlldayFilter, selectedAlldayFilter) ||
                other.selectedAlldayFilter == selectedAlldayFilter) &&
            (identical(other.selectedDailyFilter, selectedDailyFilter) ||
                other.selectedDailyFilter == selectedDailyFilter) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingTab, isLoadingTab) ||
                other.isLoadingTab == isLoadingTab) &&
            (identical(other.currentTabType, currentTabType) ||
                other.currentTabType == currentTabType) &&
            const DeepCollectionEquality().equals(other._tabCache, _tabCache) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    product,
    const DeepCollectionEquality().hash(_availableTabs),
    const DeepCollectionEquality().hash(_allPlans),
    const DeepCollectionEquality().hash(_filteredPlans),
    selectedAlldayFilter,
    selectedDailyFilter,
    isLoading,
    isLoadingTab,
    currentTabType,
    const DeepCollectionEquality().hash(_tabCache),
    error,
  );

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDetailStateImplCopyWith<_$ProductDetailStateImpl> get copyWith =>
      __$$ProductDetailStateImplCopyWithImpl<_$ProductDetailStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ProductDetailState implements ProductDetailState {
  const factory _ProductDetailState({
    final Product? product,
    final List<String> availableTabs,
    final List<ProductPlan> allPlans,
    final List<ProductPlan> filteredPlans,
    final String selectedAlldayFilter,
    final String selectedDailyFilter,
    final bool isLoading,
    final bool isLoadingTab,
    final String currentTabType,
    final Map<String, List<ProductPlan>> tabCache,
    final String? error,
  }) = _$ProductDetailStateImpl;

  @override
  Product? get product;
  @override
  List<String> get availableTabs;
  @override
  List<ProductPlan> get allPlans;
  @override
  List<ProductPlan> get filteredPlans;
  @override
  String get selectedAlldayFilter;
  @override
  String get selectedDailyFilter;
  @override
  bool get isLoading;
  @override
  bool get isLoadingTab; // 탭 전환 시 별도 로딩 상태
  @override
  String get currentTabType;
  @override
  Map<String, List<ProductPlan>> get tabCache; // 탭별 캐시
  @override
  String? get error;

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductDetailStateImplCopyWith<_$ProductDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
