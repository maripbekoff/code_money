import 'package:json_annotation/json_annotation.dart';

part 'balance_model.g.dart';

@JsonSerializable()
class BalanceModel {
  final String title;
  final num total;

  BalanceModel({
    required this.title,
    required this.total,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);
}
