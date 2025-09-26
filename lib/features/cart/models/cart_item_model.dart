import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required String productId,
    required String productName,
    required String planId,
    required String planName,
    required String planType, // 'data', 'call', 'sms'
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    String? productImageUrl,
    DateTime? addedAt,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

@freezed
class Cart with _$Cart {
  const factory Cart({
    @Default([]) List<CartItem> items,
    @Default(0.0) double totalAmount,
    DateTime? lastUpdated,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
