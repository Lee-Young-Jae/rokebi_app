import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_model.dart';

part 'product_plan_model.freezed.dart';
part 'product_plan_model.g.dart';

@freezed
class ProductPlan with _$ProductPlan {
  const factory ProductPlan({
    required String id,
    required String productId,
    required String title,
    required String description,
    required String price,
    String? originalPrice,
    String? discountPercent,
    required PlanType planType,
    String? subType, // 단품, 더블팩
    String? volume, // 500MB, 1GB, 2GB 등
    String? carrier,
    int? duration,
    required bool isUnlimited,
    @Default([]) List<String> features,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
  }) = _ProductPlan;

  factory ProductPlan.fromJson(Map<String, dynamic> json) =>
      _$ProductPlanFromJson(json);
}

enum PlanType {
  @JsonValue('allday')
  allday,
  @JsonValue('alldayplus')
  alldayplus,
  @JsonValue('daily')
  daily,
  @JsonValue('payasyougo')
  payasyougo;

  String get displayName {
    switch (this) {
      case PlanType.allday:
        return '올데이';
      case PlanType.alldayplus:
        return '올데이+';
      case PlanType.daily:
        return '데일리';
      case PlanType.payasyougo:
        return '종량제';
    }
  }
}
