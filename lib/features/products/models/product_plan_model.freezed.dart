// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductPlan _$ProductPlanFromJson(Map<String, dynamic> json) {
  return _ProductPlan.fromJson(json);
}

/// @nodoc
mixin _$ProductPlan {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String? get originalPrice => throw _privateConstructorUsedError;
  String? get discountPercent => throw _privateConstructorUsedError;
  PlanType get planType => throw _privateConstructorUsedError;
  String? get subType => throw _privateConstructorUsedError; // 단품, 더블팩
  String? get volume => throw _privateConstructorUsedError; // 500MB, 1GB, 2GB 등
  String? get carrier => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  bool get isUnlimited => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;

  /// Serializes this ProductPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductPlanCopyWith<ProductPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductPlanCopyWith<$Res> {
  factory $ProductPlanCopyWith(
    ProductPlan value,
    $Res Function(ProductPlan) then,
  ) = _$ProductPlanCopyWithImpl<$Res, ProductPlan>;
  @useResult
  $Res call({
    String id,
    String productId,
    String title,
    String description,
    String price,
    String? originalPrice,
    String? discountPercent,
    PlanType planType,
    String? subType,
    String? volume,
    String? carrier,
    int? duration,
    bool isUnlimited,
    List<String> features,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
  });

  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$ProductPlanCopyWithImpl<$Res, $Val extends ProductPlan>
    implements $ProductPlanCopyWith<$Res> {
  _$ProductPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? originalPrice = freezed,
    Object? discountPercent = freezed,
    Object? planType = null,
    Object? subType = freezed,
    Object? volume = freezed,
    Object? carrier = freezed,
    Object? duration = freezed,
    Object? isUnlimited = null,
    Object? features = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? product = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String,
            originalPrice: freezed == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountPercent: freezed == discountPercent
                ? _value.discountPercent
                : discountPercent // ignore: cast_nullable_to_non_nullable
                      as String?,
            planType: null == planType
                ? _value.planType
                : planType // ignore: cast_nullable_to_non_nullable
                      as PlanType,
            subType: freezed == subType
                ? _value.subType
                : subType // ignore: cast_nullable_to_non_nullable
                      as String?,
            volume: freezed == volume
                ? _value.volume
                : volume // ignore: cast_nullable_to_non_nullable
                      as String?,
            carrier: freezed == carrier
                ? _value.carrier
                : carrier // ignore: cast_nullable_to_non_nullable
                      as String?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int?,
            isUnlimited: null == isUnlimited
                ? _value.isUnlimited
                : isUnlimited // ignore: cast_nullable_to_non_nullable
                      as bool,
            features: null == features
                ? _value.features
                : features // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            product: freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as Product?,
          )
          as $Val,
    );
  }

  /// Create a copy of ProductPlan
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
abstract class _$$ProductPlanImplCopyWith<$Res>
    implements $ProductPlanCopyWith<$Res> {
  factory _$$ProductPlanImplCopyWith(
    _$ProductPlanImpl value,
    $Res Function(_$ProductPlanImpl) then,
  ) = __$$ProductPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String productId,
    String title,
    String description,
    String price,
    String? originalPrice,
    String? discountPercent,
    PlanType planType,
    String? subType,
    String? volume,
    String? carrier,
    int? duration,
    bool isUnlimited,
    List<String> features,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
  });

  @override
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$ProductPlanImplCopyWithImpl<$Res>
    extends _$ProductPlanCopyWithImpl<$Res, _$ProductPlanImpl>
    implements _$$ProductPlanImplCopyWith<$Res> {
  __$$ProductPlanImplCopyWithImpl(
    _$ProductPlanImpl _value,
    $Res Function(_$ProductPlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? originalPrice = freezed,
    Object? discountPercent = freezed,
    Object? planType = null,
    Object? subType = freezed,
    Object? volume = freezed,
    Object? carrier = freezed,
    Object? duration = freezed,
    Object? isUnlimited = null,
    Object? features = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? product = freezed,
  }) {
    return _then(
      _$ProductPlanImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String,
        originalPrice: freezed == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountPercent: freezed == discountPercent
            ? _value.discountPercent
            : discountPercent // ignore: cast_nullable_to_non_nullable
                  as String?,
        planType: null == planType
            ? _value.planType
            : planType // ignore: cast_nullable_to_non_nullable
                  as PlanType,
        subType: freezed == subType
            ? _value.subType
            : subType // ignore: cast_nullable_to_non_nullable
                  as String?,
        volume: freezed == volume
            ? _value.volume
            : volume // ignore: cast_nullable_to_non_nullable
                  as String?,
        carrier: freezed == carrier
            ? _value.carrier
            : carrier // ignore: cast_nullable_to_non_nullable
                  as String?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int?,
        isUnlimited: null == isUnlimited
            ? _value.isUnlimited
            : isUnlimited // ignore: cast_nullable_to_non_nullable
                  as bool,
        features: null == features
            ? _value._features
            : features // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        product: freezed == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as Product?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductPlanImpl implements _ProductPlan {
  const _$ProductPlanImpl({
    required this.id,
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
    this.originalPrice,
    this.discountPercent,
    required this.planType,
    this.subType,
    this.volume,
    this.carrier,
    this.duration,
    required this.isUnlimited,
    final List<String> features = const [],
    this.createdAt,
    this.updatedAt,
    this.product,
  }) : _features = features;

  factory _$ProductPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final String title;
  @override
  final String description;
  @override
  final String price;
  @override
  final String? originalPrice;
  @override
  final String? discountPercent;
  @override
  final PlanType planType;
  @override
  final String? subType;
  // 단품, 더블팩
  @override
  final String? volume;
  // 500MB, 1GB, 2GB 등
  @override
  final String? carrier;
  @override
  final int? duration;
  @override
  final bool isUnlimited;
  final List<String> _features;
  @override
  @JsonKey()
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final Product? product;

  @override
  String toString() {
    return 'ProductPlan(id: $id, productId: $productId, title: $title, description: $description, price: $price, originalPrice: $originalPrice, discountPercent: $discountPercent, planType: $planType, subType: $subType, volume: $volume, carrier: $carrier, duration: $duration, isUnlimited: $isUnlimited, features: $features, createdAt: $createdAt, updatedAt: $updatedAt, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.planType, planType) ||
                other.planType == planType) &&
            (identical(other.subType, subType) || other.subType == subType) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.carrier, carrier) || other.carrier == carrier) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.isUnlimited, isUnlimited) ||
                other.isUnlimited == isUnlimited) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    title,
    description,
    price,
    originalPrice,
    discountPercent,
    planType,
    subType,
    volume,
    carrier,
    duration,
    isUnlimited,
    const DeepCollectionEquality().hash(_features),
    createdAt,
    updatedAt,
    product,
  );

  /// Create a copy of ProductPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductPlanImplCopyWith<_$ProductPlanImpl> get copyWith =>
      __$$ProductPlanImplCopyWithImpl<_$ProductPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductPlanImplToJson(this);
  }
}

abstract class _ProductPlan implements ProductPlan {
  const factory _ProductPlan({
    required final String id,
    required final String productId,
    required final String title,
    required final String description,
    required final String price,
    final String? originalPrice,
    final String? discountPercent,
    required final PlanType planType,
    final String? subType,
    final String? volume,
    final String? carrier,
    final int? duration,
    required final bool isUnlimited,
    final List<String> features,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Product? product,
  }) = _$ProductPlanImpl;

  factory _ProductPlan.fromJson(Map<String, dynamic> json) =
      _$ProductPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  String get title;
  @override
  String get description;
  @override
  String get price;
  @override
  String? get originalPrice;
  @override
  String? get discountPercent;
  @override
  PlanType get planType;
  @override
  String? get subType; // 단품, 더블팩
  @override
  String? get volume; // 500MB, 1GB, 2GB 등
  @override
  String? get carrier;
  @override
  int? get duration;
  @override
  bool get isUnlimited;
  @override
  List<String> get features;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  Product? get product;

  /// Create a copy of ProductPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductPlanImplCopyWith<_$ProductPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
