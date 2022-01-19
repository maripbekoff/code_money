// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sheet_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SheetProperties _$SheetPropertiesFromJson(Map<String, dynamic> json) =>
    SheetProperties(
      id: json['sheetId'] as int,
      index: json['index'] as int,
      title: json['title'] as String,
    );

Map<String, dynamic> _$SheetPropertiesToJson(SheetProperties instance) =>
    <String, dynamic>{
      'sheetId': instance.id,
      'index': instance.index,
      'title': instance.title,
    };
