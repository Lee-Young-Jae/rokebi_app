// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get purchaseCount => throw _privateConstructorUsedError;
  ProductRegion get region => throw _privateConstructorUsedError;
  List<ProductBadge> get badges => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get originalPrice => throw _privateConstructorUsedError;
  String? get discountPercent => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    String id,
    String title,
    String price,
    String imageUrl,
    String purchaseCount,
    ProductRegion region,
    List<ProductBadge> badges,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? originalPrice,
    String? discountPercent,
  });
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? price = null,
    Object? imageUrl = null,
    Object? purchaseCount = null,
    Object? region = null,
    Object? badges = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? originalPrice = freezed,
    Object? discountPercent = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            purchaseCount: null == purchaseCount
                ? _value.purchaseCount
                : purchaseCount // ignore: cast_nullable_to_non_nullable
                      as String,
            region: null == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as ProductRegion,
            badges: null == badges
                ? _value.badges
                : badges // ignore: cast_nullable_to_non_nullable
                      as List<ProductBadge>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            originalPrice: freezed == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountPercent: freezed == discountPercent
                ? _value.discountPercent
                : discountPercent // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String price,
    String imageUrl,
    String purchaseCount,
    ProductRegion region,
    List<ProductBadge> badges,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? originalPrice,
    String? discountPercent,
  });
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? price = null,
    Object? imageUrl = null,
    Object? purchaseCount = null,
    Object? region = null,
    Object? badges = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? originalPrice = freezed,
    Object? discountPercent = freezed,
  }) {
    return _then(
      _$ProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        purchaseCount: null == purchaseCount
            ? _value.purchaseCount
            : purchaseCount // ignore: cast_nullable_to_non_nullable
                  as String,
        region: null == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as ProductRegion,
        badges: null == badges
            ? _value._badges
            : badges // ignore: cast_nullable_to_non_nullable
                  as List<ProductBadge>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        originalPrice: freezed == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountPercent: freezed == discountPercent
            ? _value.discountPercent
            : discountPercent // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.purchaseCount,
    required this.region,
    final List<ProductBadge> badges = const [],
    this.createdAt,
    this.updatedAt,
    this.originalPrice,
    this.discountPercent,
  }) : _badges = badges;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String price;
  @override
  final String imageUrl;
  @override
  final String purchaseCount;
  @override
  final ProductRegion region;
  final List<ProductBadge> _badges;
  @override
  @JsonKey()
  List<ProductBadge> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? originalPrice;
  @override
  final String? discountPercent;

  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: $price, imageUrl: $imageUrl, purchaseCount: $purchaseCount, region: $region, badges: $badges, createdAt: $createdAt, updatedAt: $updatedAt, originalPrice: $originalPrice, discountPercent: $discountPercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.purchaseCount, purchaseCount) ||
                other.purchaseCount == purchaseCount) &&
            (identical(other.region, region) || other.region == region) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    price,
    imageUrl,
    purchaseCount,
    region,
    const DeepCollectionEquality().hash(_badges),
    createdAt,
    updatedAt,
    originalPrice,
    discountPercent,
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product({
    required final String id,
    required final String title,
    required final String price,
    required final String imageUrl,
    required final String purchaseCount,
    required final ProductRegion region,
    final List<ProductBadge> badges,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final String? originalPrice,
    final String? discountPercent,
  }) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get price;
  @override
  String get imageUrl;
  @override
  String get purchaseCount;
  @override
  ProductRegion get region;
  @override
  List<ProductBadge> get badges;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get originalPrice;
  @override
  String? get discountPercent;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductBadge _$ProductBadgeFromJson(Map<String, dynamic> json) {
  return _ProductBadge.fromJson(json);
}

/// @nodoc
mixin _$ProductBadge {
  String get text => throw _privateConstructorUsedError;
  ProductBadgeType get type => throw _privateConstructorUsedError;
  bool? get hasIcon => throw _privateConstructorUsedError;

  /// Serializes this ProductBadge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductBadgeCopyWith<ProductBadge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductBadgeCopyWith<$Res> {
  factory $ProductBadgeCopyWith(
    ProductBadge value,
    $Res Function(ProductBadge) then,
  ) = _$ProductBadgeCopyWithImpl<$Res, ProductBadge>;
  @useResult
  $Res call({String text, ProductBadgeType type, bool? hasIcon});
}

/// @nodoc
class _$ProductBadgeCopyWithImpl<$Res, $Val extends ProductBadge>
    implements $ProductBadgeCopyWith<$Res> {
  _$ProductBadgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? type = null,
    Object? hasIcon = freezed,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ProductBadgeType,
            hasIcon: freezed == hasIcon
                ? _value.hasIcon
                : hasIcon // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductBadgeImplCopyWith<$Res>
    implements $ProductBadgeCopyWith<$Res> {
  factory _$$ProductBadgeImplCopyWith(
    _$ProductBadgeImpl value,
    $Res Function(_$ProductBadgeImpl) then,
  ) = __$$ProductBadgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, ProductBadgeType type, bool? hasIcon});
}

/// @nodoc
class __$$ProductBadgeImplCopyWithImpl<$Res>
    extends _$ProductBadgeCopyWithImpl<$Res, _$ProductBadgeImpl>
    implements _$$ProductBadgeImplCopyWith<$Res> {
  __$$ProductBadgeImplCopyWithImpl(
    _$ProductBadgeImpl _value,
    $Res Function(_$ProductBadgeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? type = null,
    Object? hasIcon = freezed,
  }) {
    return _then(
      _$ProductBadgeImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ProductBadgeType,
        hasIcon: freezed == hasIcon
            ? _value.hasIcon
            : hasIcon // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductBadgeImpl implements _ProductBadge {
  const _$ProductBadgeImpl({
    required this.text,
    required this.type,
    this.hasIcon,
  });

  factory _$ProductBadgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductBadgeImplFromJson(json);

  @override
  final String text;
  @override
  final ProductBadgeType type;
  @override
  final bool? hasIcon;

  @override
  String toString() {
    return 'ProductBadge(text: $text, type: $type, hasIcon: $hasIcon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductBadgeImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.hasIcon, hasIcon) || other.hasIcon == hasIcon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, type, hasIcon);

  /// Create a copy of ProductBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductBadgeImplCopyWith<_$ProductBadgeImpl> get copyWith =>
      __$$ProductBadgeImplCopyWithImpl<_$ProductBadgeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductBadgeImplToJson(this);
  }
}

abstract class _ProductBadge implements ProductBadge {
  const factory _ProductBadge({
    required final String text,
    required final ProductBadgeType type,
    final bool? hasIcon,
  }) = _$ProductBadgeImpl;

  factory _ProductBadge.fromJson(Map<String, dynamic> json) =
      _$ProductBadgeImpl.fromJson;

  @override
  String get text;
  @override
  ProductBadgeType get type;
  @override
  bool? get hasIcon;

  /// Create a copy of ProductBadge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductBadgeImplCopyWith<_$ProductBadgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
