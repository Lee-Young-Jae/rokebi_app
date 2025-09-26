// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return _Plan.fromJson(json);
}

/// @nodoc
mixin _$Plan {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  int get originalPrice => throw _privateConstructorUsedError;
  int get discountRate => throw _privateConstructorUsedError;
  int get finalPrice => throw _privateConstructorUsedError;
  int get validDays => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;

  /// Serializes this Plan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanCopyWith<Plan> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanCopyWith<$Res> {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) then) =
      _$PlanCopyWithImpl<$Res, Plan>;
  @useResult
  $Res call({
    String id,
    String productId,
    String title,
    String type,
    String amount,
    int originalPrice,
    int discountRate,
    int finalPrice,
    int validDays,
    String? description,
    List<String> features,
  });
}

/// @nodoc
class _$PlanCopyWithImpl<$Res, $Val extends Plan>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? title = null,
    Object? type = null,
    Object? amount = null,
    Object? originalPrice = null,
    Object? discountRate = null,
    Object? finalPrice = null,
    Object? validDays = null,
    Object? description = freezed,
    Object? features = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String,
            originalPrice: null == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            discountRate: null == discountRate
                ? _value.discountRate
                : discountRate // ignore: cast_nullable_to_non_nullable
                      as int,
            finalPrice: null == finalPrice
                ? _value.finalPrice
                : finalPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            validDays: null == validDays
                ? _value.validDays
                : validDays // ignore: cast_nullable_to_non_nullable
                      as int,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            features: null == features
                ? _value.features
                : features // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlanImplCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$$PlanImplCopyWith(
    _$PlanImpl value,
    $Res Function(_$PlanImpl) then,
  ) = __$$PlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String productId,
    String title,
    String type,
    String amount,
    int originalPrice,
    int discountRate,
    int finalPrice,
    int validDays,
    String? description,
    List<String> features,
  });
}

/// @nodoc
class __$$PlanImplCopyWithImpl<$Res>
    extends _$PlanCopyWithImpl<$Res, _$PlanImpl>
    implements _$$PlanImplCopyWith<$Res> {
  __$$PlanImplCopyWithImpl(_$PlanImpl _value, $Res Function(_$PlanImpl) _then)
    : super(_value, _then);

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? title = null,
    Object? type = null,
    Object? amount = null,
    Object? originalPrice = null,
    Object? discountRate = null,
    Object? finalPrice = null,
    Object? validDays = null,
    Object? description = freezed,
    Object? features = null,
  }) {
    return _then(
      _$PlanImpl(
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
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        originalPrice: null == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        discountRate: null == discountRate
            ? _value.discountRate
            : discountRate // ignore: cast_nullable_to_non_nullable
                  as int,
        finalPrice: null == finalPrice
            ? _value.finalPrice
            : finalPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        validDays: null == validDays
            ? _value.validDays
            : validDays // ignore: cast_nullable_to_non_nullable
                  as int,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        features: null == features
            ? _value._features
            : features // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanImpl implements _Plan {
  const _$PlanImpl({
    required this.id,
    required this.productId,
    required this.title,
    required this.type,
    required this.amount,
    required this.originalPrice,
    required this.discountRate,
    required this.finalPrice,
    required this.validDays,
    this.description,
    final List<String> features = const [],
  }) : _features = features;

  factory _$PlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final String title;
  @override
  final String type;
  @override
  final String amount;
  @override
  final int originalPrice;
  @override
  final int discountRate;
  @override
  final int finalPrice;
  @override
  final int validDays;
  @override
  final String? description;
  final List<String> _features;
  @override
  @JsonKey()
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  String toString() {
    return 'Plan(id: $id, productId: $productId, title: $title, type: $type, amount: $amount, originalPrice: $originalPrice, discountRate: $discountRate, finalPrice: $finalPrice, validDays: $validDays, description: $description, features: $features)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.discountRate, discountRate) ||
                other.discountRate == discountRate) &&
            (identical(other.finalPrice, finalPrice) ||
                other.finalPrice == finalPrice) &&
            (identical(other.validDays, validDays) ||
                other.validDays == validDays) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    title,
    type,
    amount,
    originalPrice,
    discountRate,
    finalPrice,
    validDays,
    description,
    const DeepCollectionEquality().hash(_features),
  );

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanImplCopyWith<_$PlanImpl> get copyWith =>
      __$$PlanImplCopyWithImpl<_$PlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanImplToJson(this);
  }
}

abstract class _Plan implements Plan {
  const factory _Plan({
    required final String id,
    required final String productId,
    required final String title,
    required final String type,
    required final String amount,
    required final int originalPrice,
    required final int discountRate,
    required final int finalPrice,
    required final int validDays,
    final String? description,
    final List<String> features,
  }) = _$PlanImpl;

  factory _Plan.fromJson(Map<String, dynamic> json) = _$PlanImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  String get title;
  @override
  String get type;
  @override
  String get amount;
  @override
  int get originalPrice;
  @override
  int get discountRate;
  @override
  int get finalPrice;
  @override
  int get validDays;
  @override
  String? get description;
  @override
  List<String> get features;

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanImplCopyWith<_$PlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
