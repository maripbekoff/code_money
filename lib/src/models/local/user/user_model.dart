import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(1)
  final String photoUrl;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String email;

  UserModel({
    required this.photoUrl,
    required this.name,
    required this.email,
  });
}
