// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanImpl _$$PlanImplFromJson(Map<String, dynamic> json) => _$PlanImpl(
  id: json['id'] as String,
  productId: json['productId'] as String,
  title: json['title'] as String,
  type: json['type'] as String,
  amount: json['amount'] as String,
  originalPrice: (json['originalPrice'] as num).toInt(),
  discountRate: (json['discountRate'] as num).toInt(),
  finalPrice: (json['finalPrice'] as num).toInt(),
  validDays: (json['validDays'] as num).toInt(),
  description: json['description'] as String?,
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$PlanImplToJson(_$PlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'title': instance.title,
      'type': instance.type,
      'amount': instance.amount,
      'originalPrice': instance.originalPrice,
      'discountRate': instance.discountRate,
      'finalPrice': instance.finalPrice,
      'validDays': instance.validDays,
      'description': instance.description,
      'features': instance.features,
    };
