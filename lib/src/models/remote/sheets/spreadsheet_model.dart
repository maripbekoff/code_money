import 'package:json_annotation/json_annotation.dart';

import 'sheet_model.dart';
import 'spreadsheet_properties.dart';

part 'spreadsheet_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SpreadsheetModel {
  @JsonKey(name: 'spreadsheetId')
  final String id;
  @JsonKey(name: 'spreadsheetUrl')
  final String url;
  final SpreadsheetProperties properties;
  final List<SheetModel> sheets;

  SpreadsheetModel({
    required this.id,
    required this.url,
    required this.properties,
    required this.sheets,
  });

  factory SpreadsheetModel.fromJson(Map<String, dynamic> json) =>
      _$SpreadsheetModelFromJson(json);
  Map<String, dynamic> toJson() => _$SpreadsheetModelToJson(this);
}
