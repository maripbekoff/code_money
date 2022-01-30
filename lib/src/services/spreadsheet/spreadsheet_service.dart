import 'package:code_money/environment_config.dart';
import 'package:code_money/src/common/dio/app_dio.dart';
import 'package:code_money/src/models/remote/articles/article_model.dart';
import 'package:code_money/src/models/remote/balance/balance_model.dart';
import 'package:code_money/src/models/remote/directions/direction_model.dart';
import 'package:code_money/src/models/remote/sheets/spreadsheet_model.dart';
import 'package:code_money/src/models/remote/transactions/transaction_id_model.dart';
import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:dio/dio.dart';

abstract class SpreadsheetService {
  Future<SpreadsheetModel> getSpeadsheet();
  Future<BalanceModel> getTotalBalance();
  Future<List<BalanceModel>> getBalances();
  Future<List<DirectionModel>> getDirections();
  Future<List<ArticleModel>> getArticles();
  Future<List<TransactionModel>> getTransactions();
  Future<void> createTransaction({required TransactionModel transaction});
  Future<void> deleteTransaction({required String rowId});
  Future<void> editTransaction({required TransactionModel transaction});
}

class SpreadsheetServiceImpl implements SpreadsheetService {
  late Dio dio;

  SpreadsheetServiceImpl({required SpreadsheetDio spreadsheetDio}) {
    dio = spreadsheetDio.dio;
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
  Future<BalanceModel> getTotalBalance() async {
    try {
      final Response res = await dio.get(
        EnvironmentConfig.spreadsheetId + '/values/A1:A3',
        queryParameters: {
          'majorDimension': 'COLUMNS',
          'valueRenderOption': 'UNFORMATTED_VALUE',
        },
      );

      final List cells = res.data['values'].first;

      return BalanceModel(title: cells.first, total: cells.last);
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

      if (res.data['values'] == null) {
        return [];
      }

      int i = 5;

      List<TransactionModel> list = [];

      for (final e in res.data['values'] as List) {
        if (e.isEmpty) {
          i++;
          continue;
        }
        list.add(TransactionModel(
          id: TransactionIdModel(
            id: 'A$i:K$i',
            rowId: '$i',
            columnId: '$i',
            firstColumnLetterId: 'A',
            secondColumnLetterId: 'K',
          ),
          month: e[0],
          monthNum: e[1],
          date: dateFromStringToDateTime(e[2]),
          sum: e[3].toDouble(),
          wallet: e[4],
          direction: e[5],
          counterAgent: e[6],
          appointment: e[7],
          article: e[8],
          isAdmission: e[9] == 'Поступление',
          kindOfActivity: e[10],
        ));
        i++;
      }

      return list;
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
              dateFromDateTimeToString(transaction.date),
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

  @override
  Future<void> deleteTransaction({required String rowId}) async {
    try {
      await dio.post(
        EnvironmentConfig.spreadsheetId + '/values:batchClear',
        data: {
          "ranges": ["C$rowId:I$rowId"],
        },
      );
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTransaction({required TransactionModel transaction}) async {
    try {
      await dio.post(
        EnvironmentConfig.spreadsheetId + '/values:batchUpdate',
        data: {
          "valueInputOption": "USER_ENTERED",
          "data": [
            {
              "range": "C${transaction.id!.rowId}:I${transaction.id!.rowId}",
              "majorDimension": "ROWS",
              "values": [
                [
                  dateFromDateTimeToString(transaction.date),
                  transaction.sum,
                  transaction.wallet,
                  transaction.direction,
                  transaction.counterAgent,
                  transaction.appointment,
                  transaction.article,
                ]
              ],
            },
          ],
          "includeValuesInResponse": false,
        },
      );
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
