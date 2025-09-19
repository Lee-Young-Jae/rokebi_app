import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../models/product_list_state.dart';
import '../repositories/product_repository.dart';
import '../../../core/errors/global_error_handler.dart';

class ProductListViewModel extends StateNotifier<ProductListState> {
  final ProductRepository _repository;

  ProductListViewModel(this._repository) : super(const ProductListState());

  Future<void> loadAllProducts() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final products = await _repository.getAllProducts();
      state = state.copyWith(products: products, isLoading: false);
    } catch (e, stackTrace) {
      final appError = GlobalErrorHandler.handleError(e, stackTrace);
      state = state.copyWith(error: appError, isLoading: false);
    }
  }

  Future<void> loadProductsByRegion(ProductRegion region) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      selectedRegion: region,
    );

    try {
      final products = await _repository.getAllProducts(region: region);
      state = state.copyWith(products: products, isLoading: false);
    } catch (e, stackTrace) {
      final appError = GlobalErrorHandler.handleError(e, stackTrace);
      state = state.copyWith(error: appError, isLoading: false);
    }
  }

  void selectRegion(ProductRegion region) {
    if (state.selectedRegion != region) {
      loadProductsByRegion(region);
    }
  }

  void retry() {
    if (state.selectedRegion == ProductRegion.asia) {
      loadAllProducts();
    } else {
      loadProductsByRegion(state.selectedRegion);
    }
  }
}

final productListViewModelProvider =
    StateNotifierProvider.autoDispose<ProductListViewModel, ProductListState>((
      ref,
    ) {
      final repository = ref.watch(productRepositoryProvider);
      final viewModel = ProductListViewModel(repository);
      viewModel.loadAllProducts();
      return viewModel;
    });
