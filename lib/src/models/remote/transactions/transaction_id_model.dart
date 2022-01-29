import 'package:json_annotation/json_annotation.dart';

part 'transaction_id_model.g.dart';

@JsonSerializable()
class TransactionIdModel {
  /// Координаты данной ячейки в таблице в виде - "A5:D5"
  final String id;

  /// Номер строки
  final String rowId;

  /// Номер колонны
  final String columnId;

  /// Буквенное обозначение строки
  final String firstColumnLetterId;

  /// Буквенное обозначение колонны
  final String secondColumnLetterId;

  TransactionIdModel({
    required this.id,
    required this.rowId,
    required this.columnId,
    required this.firstColumnLetterId,
    required this.secondColumnLetterId,
  });

  factory TransactionIdModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionIdModelToJson(this);
}
