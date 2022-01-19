// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spreadsheet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpreadsheetModel _$SpreadsheetModelFromJson(Map<String, dynamic> json) =>
    SpreadsheetModel(
      id: json['spreadsheetId'] as String,
      url: json['spreadsheetUrl'] as String,
      properties: SpreadsheetProperties.fromJson(
          json['properties'] as Map<String, dynamic>),
      sheets: (json['sheets'] as List<dynamic>)
          .map((e) => SheetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpreadsheetModelToJson(SpreadsheetModel instance) =>
    <String, dynamic>{
      'spreadsheetId': instance.id,
      'spreadsheetUrl': instance.url,
      'properties': instance.properties.toJson(),
      'sheets': instance.sheets.map((e) => e.toJson()).toList(),
    };
