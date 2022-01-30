import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:flutter/widgets.dart';

class AddTransactionScreenArgs {
  // Функция, выполняющаяся после успешного сохранения записи в таблице
  final VoidCallback onCreated;
  final TransactionModel? transaction;

  AddTransactionScreenArgs({
    required this.onCreated,
  }) : transaction = null;

  AddTransactionScreenArgs.edit({
    required this.onCreated,
    required this.transaction,
  });
}
