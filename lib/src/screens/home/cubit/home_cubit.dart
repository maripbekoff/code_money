import 'package:bloc/bloc.dart';
import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/models/remote/articles/article_model.dart';
import 'package:code_money/src/models/remote/balance/balance_model.dart';
import 'package:code_money/src/models/remote/directions/direction_model.dart';
import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:code_money/src/services/spreadsheet/spreadsheet_service.dart';
import 'package:dio/dio.dart';
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
      BalanceModel totalBalance = await spreadsheetService.getTotalBalance();
      List<BalanceModel> balances = await spreadsheetService.getBalances();
      List<TransactionModel> transactions =
          await spreadsheetService.getTransactions();
      List<ArticleModel> articles = await spreadsheetService.getArticles();
      List<DirectionModel> directions =
          await spreadsheetService.getDirections();

      if (!getIt.isRegistered<List<BalanceModel>>()) {
        getIt.registerLazySingleton<List<BalanceModel>>(
          () => balances,
        );
        getIt.registerLazySingleton<List<ArticleModel>>(
          () => articles,
        );
        getIt.registerLazySingleton<List<DirectionModel>>(
          () => directions,
        );
      }

      transactions.sort((d1, d2) {
        if (d1.date.isAfter(d2.date)) {
          return 1;
        } else {
          return -1;
        }
      });

      emit(HomeLoaded(
        totalBalance: totalBalance,
        balances: balances,
        transactions: transactions.reversed.toList(),
      ));
    } on DioError catch (e) {
      if ((e.response?.statusCode ?? 0) == 403) {
        emit(NoPermissions());
        return;
      }
      emit(HomeFailed());
      rethrow;
    } catch (e) {
      emit(HomeFailed());
      rethrow;
    }
  }
}
