import 'package:json_annotation/json_annotation.dart';

import 'sheet_properties.dart';

part 'sheet_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SheetModel {
  final SheetProperties properties;

  SheetModel({
    required this.properties,
  });

  factory SheetModel.fromJson(Map<String, dynamic> json) =>
      _$SheetModelFromJson(json);
  Map<String, dynamic> toJson() => _$SheetModelToJson(this);
}
