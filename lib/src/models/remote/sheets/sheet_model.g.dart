// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sheet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SheetModel _$SheetModelFromJson(Map<String, dynamic> json) => SheetModel(
      properties:
          SheetProperties.fromJson(json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SheetModelToJson(SheetModel instance) =>
    <String, dynamic>{
      'properties': instance.properties.toJson(),
    };
