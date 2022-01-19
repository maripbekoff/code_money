import 'package:json_annotation/json_annotation.dart';

part 'direction_model.g.dart';

@JsonSerializable()
class DirectionModel {
  final String title;

  DirectionModel({
    required this.title,
  });

  factory DirectionModel.fromJson(Map<String, dynamic> json) =>
      _$DirectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$DirectionModelToJson(this);
}
