import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/cart_item_model.dart';

class CartStorageService {
  static const String _cartKey = 'shopping_cart';
  final FlutterSecureStorage _storage;

  CartStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  // 카트 저장
  Future<void> saveCart(Cart cart) async {
    final cartJson = jsonEncode(cart.toJson());
    await _storage.write(key: _cartKey, value: cartJson);
  }

  // 카트 불러오기
  Future<Cart?> loadCart() async {
    try {
      final cartJson = await _storage.read(key: _cartKey);
      if (cartJson != null) {
        final cartMap = jsonDecode(cartJson) as Map<String, dynamic>;
        return Cart.fromJson(cartMap);
      }
      return null;
    } catch (e) {
      print('Error loading cart: $e');
      return null;
    }
  }

  // 카트 비우기
  Future<void> clearCart() async {
    await _storage.delete(key: _cartKey);
  }

  // 카트에 아이템 추가
  Future<Cart> addItem(Cart currentCart, CartItem newItem) async {
    final existingItemIndex = currentCart.items.indexWhere(
      (item) => item.planId == newItem.planId,
    );

    List<CartItem> updatedItems;

    if (existingItemIndex != -1) {
      // 이미 존재하는 아이템이면 수량 업데이트
      updatedItems = [...currentCart.items];
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + newItem.quantity,
        totalPrice:
            existingItem.unitPrice * (existingItem.quantity + newItem.quantity),
      );
    } else {
      // 새로운 아이템 추가
      updatedItems = [...currentCart.items, newItem];
    }

    // 총 금액 재계산
    final totalAmount = updatedItems.fold(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    final updatedCart = currentCart.copyWith(
      items: updatedItems,
      totalAmount: totalAmount,
      lastUpdated: DateTime.now(),
    );

    await saveCart(updatedCart);
    return updatedCart;
  }

  // 카트에서 아이템 제거
  Future<Cart> removeItem(Cart currentCart, String itemId) async {
    final updatedItems = currentCart.items
        .where((item) => item.id != itemId)
        .toList();

    final totalAmount = updatedItems.fold(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    final updatedCart = currentCart.copyWith(
      items: updatedItems,
      totalAmount: totalAmount,
      lastUpdated: DateTime.now(),
    );

    await saveCart(updatedCart);
    return updatedCart;
  }

  // 수량 업데이트
  Future<Cart> updateItemQuantity(
    Cart currentCart,
    String itemId,
    int newQuantity,
  ) async {
    if (newQuantity <= 0) {
      return removeItem(currentCart, itemId);
    }

    final updatedItems = currentCart.items.map((item) {
      if (item.id == itemId) {
        return item.copyWith(
          quantity: newQuantity,
          totalPrice: item.unitPrice * newQuantity,
        );
      }
      return item;
    }).toList();

    final totalAmount = updatedItems.fold(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    final updatedCart = currentCart.copyWith(
      items: updatedItems,
      totalAmount: totalAmount,
      lastUpdated: DateTime.now(),
    );

    await saveCart(updatedCart);
    return updatedCart;
  }
}
