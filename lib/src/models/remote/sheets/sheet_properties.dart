import 'package:json_annotation/json_annotation.dart';

part 'sheet_properties.g.dart';

@JsonSerializable()
class SheetProperties {
  @JsonKey(name: 'sheetId')
  final int id;
  final int index;
  final String title;

  SheetProperties({
    required this.id,
    required this.index,
    required this.title,
  });

  factory SheetProperties.fromJson(Map<String, dynamic> json) =>
      _$SheetPropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$SheetPropertiesToJson(this);
}
