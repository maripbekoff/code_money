import 'package:json_annotation/json_annotation.dart';

part 'release_model.g.dart';

@JsonSerializable()
class ReleaseModel {
  final int id;

  final String name;

  @JsonKey(name: 'upload_url')
  final String uploadUrl;

  @JsonKey(name: 'tag_name')
  final String tagName;

  @JsonKey(name: 'target_commitish')
  final String targetCommitish;

  @JsonKey(name: 'html_url')
  final String releaseUrl;

  ReleaseModel({
    required this.id,
    required this.name,
    required this.uploadUrl,
    required this.tagName,
    required this.targetCommitish,
    required this.releaseUrl,
  });

  factory ReleaseModel.fromJson(Map<String, dynamic> json) =>
      _$ReleaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseModelToJson(this);
}
