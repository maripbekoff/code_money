import 'package:hive_flutter/hive_flutter.dart';

Future initHive() async {
  await Hive.initFlutter();

  await Hive.openBox('tokens');
}
