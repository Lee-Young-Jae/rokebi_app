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

  // 특정 아이템의 선택 상태 토글
  void toggleItemSelection(String itemId) {
    final updatedItems = state.items.map((item) {
      if (item.id == itemId) {
        return item.copyWith(isSelected: !item.isSelected);
      }
      return item;
    }).toList();

    final totalAmount = updatedItems
        .where((item) => item.isSelected)
        .fold(0.0, (sum, item) => sum + item.totalPrice);

    state = state.copyWith(items: updatedItems, totalAmount: totalAmount);
  }

  // 모든 아이템 선택/해제
  void toggleAllSelection() {
    final shouldSelectAll = !isAllSelected;
    final updatedItems = state.items.map((item) {
      return item.copyWith(isSelected: shouldSelectAll);
    }).toList();

    final totalAmount = shouldSelectAll
        ? updatedItems.fold(0.0, (sum, item) => sum + item.totalPrice)
        : 0.0;

    state = state.copyWith(items: updatedItems, totalAmount: totalAmount);
  }

  // 카트 아이템 개수
  int get itemCount => state.items.length;

  // 카트 총 아이템 수량
  int get totalQuantity =>
      state.items.fold(0, (sum, item) => sum + item.quantity);

  // 카트가 비어있는지 확인
  bool get isEmpty => state.items.isEmpty;

  // 선택된 아이템들의 총 금액 계산
  double get selectedTotalPrice {
    return state.items
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.totalPrice);
  }

  // 선택된 아이템 개수
  int get selectedItemCount {
    return state.items.where((item) => item.isSelected).length;
  }

  // 모든 아이템이 선택되었는지 확인
  bool get isAllSelected {
    if (state.items.isEmpty) return false;
    return state.items.every((item) => item.isSelected);
  }

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
