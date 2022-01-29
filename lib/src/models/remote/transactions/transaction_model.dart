import 'package:code_money/src/models/remote/transactions/transaction_id_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionModel {
  final TransactionIdModel? id;
  final String? month;
  final int? monthNum;
  @JsonKey(
    fromJson: dateFromStringToDateTime,
    toJson: dateFromDateTimeToString,
  )
  final DateTime date;
  final double sum;
  final String wallet;
  final String direction;
  final String counterAgent;
  final String appointment;
  final String article;
  final bool? isAdmission;
  final String? kindOfActivity;

  TransactionModel({
    required this.id,
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

DateTime dateFromStringToDateTime(String date) {
  final List dateList = date.split('.').map((e) => int.parse(e)).toList();

  return DateTime(
    dateList.last,
    dateList[1],
    dateList.first,
  );
}

String dateFromDateTimeToString(DateTime date) =>
    '${date.day}.${date.month}.${date.year}';
