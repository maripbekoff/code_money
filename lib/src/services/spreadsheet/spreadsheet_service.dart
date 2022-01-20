import 'package:code_money/environment_config.dart';
import 'package:code_money/src/common/dio/app_dio.dart';
import 'package:code_money/src/models/remote/articles/article_model.dart';
import 'package:code_money/src/models/remote/balance/balance_model.dart';
import 'package:code_money/src/models/remote/directions/direction_model.dart';
import 'package:code_money/src/models/remote/sheets/spreadsheet_model.dart';
import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:dio/dio.dart';

abstract class SpreadsheetService {
  Future<SpreadsheetModel> getSpeadsheet();
  Future<List<BalanceModel>> getBalances();
  Future<List<DirectionModel>> getDirections();
  Future<List<ArticleModel>> getArticles();
  Future<List<TransactionModel>> getTransactions();
  Future<void> createTransaction({required TransactionModel transaction});
}

class SpreadsheetServiceImpl implements SpreadsheetService {
  late Dio dio;

  SpreadsheetServiceImpl({required AppDio appDio}) {
    dio = appDio.dio;
  }

  @override
  Future<SpreadsheetModel> getSpeadsheet() async {
    try {
      final Response res = await dio.get(EnvironmentConfig.spreadsheetId);

      return SpreadsheetModel.fromJson(res.data);
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BalanceModel>> getBalances() async {
    try {
      final Response res = await dio.get(
        EnvironmentConfig.spreadsheetId + '/values/B1:I3',
        queryParameters: {
          'majorDimension': 'ROWS',
          'valueRenderOption': 'UNFORMATTED_VALUE',
        },
      );

      List cells = [];
      List<BalanceModel> balances = [];

      for (final c in res.data['values'] as List) {
        for (final b in c) {
          cells.add(b);
        }
      }

      int b = 0;

      for (int i = 0; i < (cells.length / 2); i++) {
        balances.add(BalanceModel(
          title: cells[b],
          total: cells[b + 1],
        ));
        b += 2;
      }

      return balances;
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final Response res = await dio.get(
        EnvironmentConfig.spreadsheetId + '/values/A5:K100',
        queryParameters: {
          'majorDimension': 'ROWS',
          'valueRenderOption': 'UNFORMATTED_VALUE',
          'dateTimeRenderOption': 'FORMATTED_STRING',
        },
      );

      return (res.data['values'] as List)
          .map(
            (e) => TransactionModel(
              month: e[0],
              monthNum: e[1],
              date: e[2],
              sum: e[3],
              wallet: e[4],
              direction: e[5],
              counterAgent: e[6],
              appointment: e[7],
              article: e[8],
              admission: e[9] == 'Поступление',
              kindOfActivity: e[10],
            ),
          )
          .toList();
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createTransaction({
    required TransactionModel transaction,
  }) async {
    try {
      await dio.post(
        EnvironmentConfig.spreadsheetId + '/values/A5:K5:append',
        queryParameters: {'valueInputOption': 'USER_ENTERED'},
        data: {
          'majorDimension': 'ROWS',
          'values': [
            [
              null,
              null,
              transaction.date,
              transaction.sum,
              transaction.wallet,
              transaction.direction,
              transaction.counterAgent,
              transaction.appointment,
              transaction.article,
              null,
              null
            ],
          ],
        },
      );
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ArticleModel>> getArticles() async {
    try {
      final Response res = await dio.get(
        EnvironmentConfig.spreadsheetId + '/values/ДДС: статьи!A2:A100',
        queryParameters: {
          'majorDimension': 'COLUMNS',
          'valueRenderOption': 'UNFORMATTED_VALUE',
        },
      );

      List<ArticleModel> list = [];

      for (final article in res.data['values'].first) {
        list.add(ArticleModel(title: article));
      }

      return list;
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DirectionModel>> getDirections() async {
    try {
      final Response res = await dio.get(
        EnvironmentConfig.spreadsheetId + '/values/Справочники!A2:A100',
        queryParameters: {
          'majorDimension': 'COLUMNS',
          'valueRenderOption': 'UNFORMATTED_VALUE',
        },
      );

      List<DirectionModel> list = [];

      for (final article in res.data['values'].first) {
        list.add(DirectionModel(title: article));
      }

      return list;
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
