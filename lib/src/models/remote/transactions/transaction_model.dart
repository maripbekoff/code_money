import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionModel {
  final String? month;
  final int? monthNum;
  final String date;
  final int sum;
  final String wallet;
  final String direction;
  final String counterAgent;
  final String appointment;
  final String article;
  final bool? isAdmission;
  final String? kindOfActivity;

  TransactionModel({
    required this.month,
    required this.monthNum,
    required this.date,
    required this.sum,
    required this.wallet,
    required this.direction,
    required this.counterAgent,
    required this.appointment,
    required this.article,
    required this.isAdmission,
    required this.kindOfActivity,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
