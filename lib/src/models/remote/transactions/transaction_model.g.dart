// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      month: json['month'] as String?,
      monthNum: json['monthNum'] as int?,
      date: json['date'] as String,
      sum: json['sum'] as int,
      wallet: json['wallet'] as String,
      direction: json['direction'] as String,
      counterAgent: json['counterAgent'] as String,
      appointment: json['appointment'] as String,
      article: json['article'] as String,
      isAdmission: json['isAdmission'] as bool?,
      kindOfActivity: json['kindOfActivity'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'month': instance.month,
      'monthNum': instance.monthNum,
      'date': instance.date,
      'sum': instance.sum,
      'wallet': instance.wallet,
      'direction': instance.direction,
      'counterAgent': instance.counterAgent,
      'appointment': instance.appointment,
      'article': instance.article,
      'isAdmission': instance.isAdmission,
      'kindOfActivity': instance.kindOfActivity,
    };
