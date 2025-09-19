import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/api_service.dart';
import '../../../core/errors/app_error.dart';
import '../models/product_plan_model.dart';

part 'product_plan_repository.g.dart';

@riverpod
ProductPlanRepository productPlanRepository(Ref ref) {
  return ProductPlanRepository();
}

class ProductPlanRepository {
  ProductPlanRepository();

  Future<List<ProductPlan>> getPlansByProductId(String productId) async {
    try {
      final response = await ApiService.get(
        "/api/products/$productId/plans",
      );
      final List<dynamic> data = response.data;
      return data.map((json) => ProductPlan.fromJson(json)).toList();
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '요금제를 불러오는데 실패했습니다.');
    }
  }

  Future<Map<String, List<ProductPlan>>> getPlansGroupedByPeriod(
    String productId,
  ) async {
    try {
      final response = await ApiService.get(
        "/api/products/$productId/plans/grouped",
      );

      final Map<String, List<ProductPlan>> groupedPlans = {};
      final List<dynamic> data = response.data;

      for (final group in data) {
        final planType = group['planType'] as String;
        final plans = (group['plans'] as List<dynamic>)
            .map((json) => ProductPlan.fromJson(json))
            .toList();
        groupedPlans[planType] = plans;
      }

      return groupedPlans;
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '그룹화된 요금제를 불러오는데 실패했습니다.');
    }
  }

  Future<ProductPlan> getPlanById(String planId) async {
    try {
      final response = await ApiService.get(
        '/api/plans/$planId',
      );
      return ProductPlan.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '요금제 상세 정보를 불러오는데 실패했습니다.');
    }
  }

  Future<ProductPlan> createPlan(String productId, ProductPlan plan) async {
    try {
      final response = await ApiService.post(
        '/api/products/$productId/plans',
        data: plan.toJson(),
      );
      return ProductPlan.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '요금제 생성에 실패했습니다.');
    }
  }

  Future<ProductPlan> updatePlan(
    String planId,
    ProductPlan plan,
  ) async {
    try {
      final response = await ApiService.put(
        '/api/plans/$planId',
        data: plan.toJson(),
      );
      return ProductPlan.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '요금제 수정에 실패했습니다.');
    }
  }

  Future<void> deletePlan(String planId) async {
    try {
      await ApiService.delete('/api/plans/$planId');
    } catch (e) {
      if (e is DioException && e.error is AppError) {
        throw e.error as AppError;
      }
      throw const AppError.unknown(message: '요금제 삭제에 실패했습니다.');
    }
  }
}
