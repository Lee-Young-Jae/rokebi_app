import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rokebi_app/features/products/models/plan_model.dart';
import '../models/cart_item_model.dart';
import '../services/cart_storage_service.dart';
import '../../products/models/product_model.dart';

// Cart Storage Service Provider
final cartStorageServiceProvider = Provider<CartStorageService>((ref) {
  return CartStorageService();
});

// Cart State Provider
final cartViewModelProvider = StateNotifierProvider<CartViewModel, Cart>((ref) {
  final storageService = ref.watch(cartStorageServiceProvider);
  return CartViewModel(storageService);
});

class CartViewModel extends StateNotifier<Cart> {
  final CartStorageService _storageService;

  CartViewModel(this._storageService) : super(const Cart()) {
    _loadCart();
  }

  // 카트 초기 로드
  Future<void> _loadCart() async {
    final loadedCart = await _storageService.loadCart();
    if (loadedCart != null) {
      state = loadedCart;
    }
  }

  // 카트에 아이템 추가
  Future<void> addToCart({
    required Product product,
    required Plan plan,
    required int quantity,
  }) async {
    final newItem = CartItem(
      id: '${plan.id}_${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      productName: product.title,
      planId: plan.id,
      planName: plan.title,
      planType: plan.type,
      quantity: quantity,
      unitPrice: plan.finalPrice.toDouble(),
      totalPrice: plan.finalPrice.toDouble() * quantity,
      productImageUrl: product.imageUrl,
      addedAt: DateTime.now(),
    );

    state = await _storageService.addItem(state, newItem);
  }

  // 카트에서 아이템 제거
  Future<void> removeFromCart(String itemId) async {
    state = await _storageService.removeItem(state, itemId);
  }

  // 아이템 수량 업데이트
  Future<void> updateQuantity(String itemId, int quantity) async {
    state = await _storageService.updateItemQuantity(state, itemId, quantity);
  }

  // 카트 비우기
  Future<void> clearCart() async {
    await _storageService.clearCart();
    state = const Cart();
  }

  // 카트 아이템 개수
  int get itemCount => state.items.length;

  // 카트 총 아이템 수량
  int get totalQuantity =>
      state.items.fold(0, (sum, item) => sum + item.quantity);

  // 카트가 비어있는지 확인
  bool get isEmpty => state.items.isEmpty;

  // 특정 플랜이 카트에 있는지 확인
  bool isInCart(String planId) {
    return state.items.any((item) => item.planId == planId);
  }

  // 특정 플랜의 수량 가져오기
  int getQuantity(String planId) {
    final item = state.items.firstWhere(
      (item) => item.planId == planId,
      orElse: () => const CartItem(
        id: '',
        productId: '',
        productName: '',
        planId: '',
        planName: '',
        planType: '',
        quantity: 0,
        unitPrice: 0,
        totalPrice: 0,
      ),
    );
    return item.quantity;
  }
}
