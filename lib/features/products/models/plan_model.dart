import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_model.freezed.dart';
part 'plan_model.g.dart';

@freezed
class Plan with _$Plan {
  const factory Plan({
    required String id,
    required String productId,
    required String title,
    required String type,
    required String amount,
    required int originalPrice,
    required int discountRate,
    required int finalPrice,
    required int validDays,
    String? description,
    @Default([]) List<String> features,
  }) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}