// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      imageUrl: json['imageUrl'] as String,
      purchaseCount: json['purchaseCount'] as String,
      region: $enumDecode(_$ProductRegionEnumMap, json['region']),
      badges:
          (json['badges'] as List<dynamic>?)
              ?.map((e) => ProductBadge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      originalPrice: json['originalPrice'] as String?,
      discountPercent: json['discountPercent'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'purchaseCount': instance.purchaseCount,
      'region': _$ProductRegionEnumMap[instance.region]!,
      'badges': instance.badges,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'originalPrice': instance.originalPrice,
      'discountPercent': instance.discountPercent,
    };

const _$ProductRegionEnumMap = {
  ProductRegion.asia: 'asia',
  ProductRegion.multiple: 'multiple',
  ProductRegion.americasOceania: 'americasOceania',
  ProductRegion.europe: 'europe',
  ProductRegion.africa: 'africa',
};

_$ProductBadgeImpl _$$ProductBadgeImplFromJson(Map<String, dynamic> json) =>
    _$ProductBadgeImpl(
      text: json['text'] as String,
      type: $enumDecode(_$ProductBadgeTypeEnumMap, json['type']),
      hasIcon: json['hasIcon'] as bool?,
    );

Map<String, dynamic> _$$ProductBadgeImplToJson(_$ProductBadgeImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'type': _$ProductBadgeTypeEnumMap[instance.type]!,
      'hasIcon': instance.hasIcon,
    };

const _$ProductBadgeTypeEnumMap = {
  ProductBadgeType.popular: 'popular',
  ProductBadgeType.allday: 'allday',
  ProductBadgeType.alldayPlus: 'alldayPlus',
  ProductBadgeType.newProduct: 'newProduct',
  ProductBadgeType.special: 'special',
  ProductBadgeType.sale: 'sale',
};
