import 'package:code_money/src/models/local/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());

  await Hive.openBox('tokens');
  await Hive.openBox('user');
}
