import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_model.dart';
import '../../../core/errors/app_error.dart';

part 'product_list_state.freezed.dart';

@freezed
class ProductListState with _$ProductListState {
  const factory ProductListState({
    @Default([]) List<Product> products,
    @Default(false) bool isLoading,
    @Default(ProductRegion.asia) ProductRegion selectedRegion,
    AppError? error,
  }) = _ProductListState;

  const ProductListState._();

  List<Product> getProductsByRegion(ProductRegion region) {
    return products.where((product) => product.region == region).toList();
  }

  bool get hasError => error != null;

  bool get hasProducts => products.isNotEmpty;

  bool get isEmpty => products.isEmpty && !isLoading;
}