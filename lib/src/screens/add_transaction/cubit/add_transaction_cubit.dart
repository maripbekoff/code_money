import 'package:bloc/bloc.dart';
import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:code_money/src/services/spreadsheet/spreadsheet_service.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  final SpreadsheetService spreadsheetService;
  final Box transactionsBox = Hive.box('transactions');

  AddTransactionCubit({
    required this.spreadsheetService,
  }) : super(AddTransactionInitial());

  addTransaction({required TransactionModel transaction}) async {
    emit(AddTransactionLoading());

    try {
      await spreadsheetService.createTransaction(transaction: transaction);
      await transactionsBox.put('wallet', transaction.wallet);
      await transactionsBox.put('direction', transaction.direction);
      emit(AddTransactionLoaded());
    } catch (e) {
      emit(AddTransactionFailed());
      rethrow;
    }
  }
}
