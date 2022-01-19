import 'package:json_annotation/json_annotation.dart';

part 'spreadsheet_properties.g.dart';

@JsonSerializable(explicitToJson: true)
class SpreadsheetProperties {
  final String title;

  SpreadsheetProperties({
    required this.title,
  });

  factory SpreadsheetProperties.fromJson(Map<String, dynamic> json) =>
      _$SpreadsheetPropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$SpreadsheetPropertiesToJson(this);
}
