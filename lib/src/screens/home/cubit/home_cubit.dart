import 'package:bloc/bloc.dart';
import 'package:code_money/src/models/remote/balance/balance_model.dart';
import 'package:code_money/src/models/remote/sheets/spreadsheet_model.dart';
import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:code_money/src/services/spreadsheet/spreadsheet_service.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  SpreadsheetService spreadsheetService;

  HomeCubit({
    required this.spreadsheetService,
  }) : super(HomeInitial());

  void init() async {
    emit(HomeLoading());

    try {
      SpreadsheetModel spreadsheet = await spreadsheetService.getSpeadsheet();
      List<BalanceModel> balances = await spreadsheetService.getBalances();
      List<TransactionModel> transactions =
          await spreadsheetService.getTransactions();

      emit(HomeLoaded(
        spreadsheet: spreadsheet,
        balances: balances,
        transactions: transactions,
      ));
    } catch (e) {
      emit(HomeFailed());
    }
  }
}
