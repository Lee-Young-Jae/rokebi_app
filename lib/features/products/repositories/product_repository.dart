import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/errors/app_error.dart';
import '../models/product_model.dart';

part 'product_repository.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository();
}

class ProductRepository {
  ProductRepository();

  Future<List<Product>> getAllProducts({ProductRegion? region}) async {
    try {
      final queryParams = region != null ? {'region': region.name} : null;

      final response = await ApiService.get(
        ApiConstants.productsEndpoint,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '제품 목록을 불러오는데 실패했습니다.');
    }
  }

  Future<List<Product>> getProductsByRegion() async {
    try {
      final response = await ApiService.get(
        ApiConstants.productsByRegionEndpoint,
      );

      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '지역별 제품을 불러오는데 실패했습니다.');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await ApiService.get(
        '${ApiConstants.productsEndpoint}/$id',
      );
      return Product.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '제품 상세 정보를 불러오는데 실패했습니다.');
    }
  }

  Future<Product> createProduct(Product product) async {
    try {
      final response = await ApiService.post(
        ApiConstants.productsEndpoint,
        data: product.toJson(),
      );
      return Product.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '제품 생성에 실패했습니다.');
    }
  }

  Future<Product> updateProduct(String id, Product product) async {
    try {
      final response = await ApiService.put(
        '${ApiConstants.productsEndpoint}/$id',
        data: product.toJson(),
      );
      return Product.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '제품 수정에 실패했습니다.');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await ApiService.delete('${ApiConstants.productsEndpoint}/$id');
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '제품 삭제에 실패했습니다.');
    }
  }
}
