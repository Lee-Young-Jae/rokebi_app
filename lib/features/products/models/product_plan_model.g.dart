// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPlanImpl _$$ProductPlanImplFromJson(Map<String, dynamic> json) =>
    _$ProductPlanImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      originalPrice: json['originalPrice'] as String?,
      discountPercent: json['discountPercent'] as String?,
      planType: $enumDecode(_$PlanTypeEnumMap, json['planType']),
      subType: json['subType'] as String?,
      volume: json['volume'] as String?,
      carrier: json['carrier'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      isUnlimited: json['isUnlimited'] as bool,
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProductPlanImplToJson(_$ProductPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'discountPercent': instance.discountPercent,
      'planType': _$PlanTypeEnumMap[instance.planType]!,
      'subType': instance.subType,
      'volume': instance.volume,
      'carrier': instance.carrier,
      'duration': instance.duration,
      'isUnlimited': instance.isUnlimited,
      'features': instance.features,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'product': instance.product,
    };

const _$PlanTypeEnumMap = {
  PlanType.allday: 'allday',
  PlanType.alldayplus: 'alldayplus',
  PlanType.daily: 'daily',
  PlanType.payasyougo: 'payasyougo',
};
