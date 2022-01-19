import 'package:bloc/bloc.dart';
import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/models/remote/articles/article_model.dart';
import 'package:code_money/src/models/remote/balance/balance_model.dart';
import 'package:code_money/src/models/remote/directions/direction_model.dart';
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
      List<BalanceModel> balances = await spreadsheetService.getBalances();
      List<TransactionModel> transactions =
          await spreadsheetService.getTransactions();
      List<ArticleModel> articles = await spreadsheetService.getArticles();
      List<DirectionModel> directions =
          await spreadsheetService.getDirections();

      getIt.registerLazySingleton<List<BalanceModel>>(() => balances);
      getIt.registerLazySingleton<List<ArticleModel>>(() => articles);
      getIt.registerLazySingleton<List<DirectionModel>>(() => directions);

      emit(HomeLoaded(
        balances: balances,
        transactions: transactions,
      ));
    } catch (e) {
      emit(HomeFailed());
      rethrow;
    }
  }
}
