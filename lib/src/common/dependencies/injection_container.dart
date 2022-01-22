import 'package:code_money/src/common/dio/app_dio.dart';
import 'package:code_money/src/services/github/github_service.dart';
import 'package:code_money/src/services/spreadsheet/spreadsheet_service.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

GetIt getIt = GetIt.I;

initGetIt() {
  getIt.registerLazySingleton<SpreadsheetDio>(() => SpreadsheetDio());

  getIt.registerLazySingleton<GithubDio>(() => GithubDio());

  getIt.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/userinfo.profile',
        'https://www.googleapis.com/auth/spreadsheets.readonly',
        'https://www.googleapis.com/auth/spreadsheets',
        'https://www.googleapis.com/auth/drive.readonly',
        'https://www.googleapis.com/auth/drive.file',
        'https://www.googleapis.com/auth/drive',
      ],
    ),
  );

  getIt.registerLazySingleton<SpreadsheetService>(
    () => SpreadsheetServiceImpl(spreadsheetDio: getIt<SpreadsheetDio>()),
  );

  getIt.registerLazySingleton<GithubService>(
    () => GithubServiceImpl(githubDio: getIt<GithubDio>()),
  );
}
