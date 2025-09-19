import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    required String price,
    required String imageUrl,
    required String purchaseCount,
    required ProductRegion region,
    @Default([]) List<ProductBadge> badges,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? originalPrice,
    String? discountPercent,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class ProductBadge with _$ProductBadge {
  const factory ProductBadge({
    required String text,
    required ProductBadgeType type,
    bool? hasIcon,
  }) = _ProductBadge;

  factory ProductBadge.fromJson(Map<String, dynamic> json) =>
      _$ProductBadgeFromJson(json);
}

enum ProductBadgeType {
  @JsonValue('popular')
  popular,
  @JsonValue('allday')
  allday,
  @JsonValue('alldayPlus')
  alldayPlus,
  @JsonValue('newProduct')
  newProduct,
  @JsonValue('special')
  special,
  @JsonValue('sale')
  sale,
}

enum ProductRegion {
  @JsonValue('asia')
  asia,
  @JsonValue('multiple')
  multiple,
  @JsonValue('americasOceania')
  americasOceania,
  @JsonValue('europe')
  europe,
  @JsonValue('africa')
  africa,
}