import 'package:flutter/widgets.dart';

class AddTransactionScreenArgs {
  // Функция, выполняющаяся после успешного сохранения записи в таблице
  final VoidCallback onCreated;

  AddTransactionScreenArgs({required this.onCreated});
}
