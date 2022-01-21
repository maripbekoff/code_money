import 'package:code_money/environment_config.dart';
import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

class SpreadsheetDio {
  Dio dio = Dio(BaseOptions(
    baseUrl: EnvironmentConfig.apiUrl,
  ))
    ..interceptors.add(DioInterceptor());

  set path(String path) => dio = Dio(
        BaseOptions(baseUrl: EnvironmentConfig.apiUrl + path),
      )..interceptors.add(DioInterceptor());
}

class GithubDio {
  Dio dio = Dio(BaseOptions(baseUrl: EnvironmentConfig.githubApiUrl));

  set path(String path) => dio = Dio(
        BaseOptions(baseUrl: EnvironmentConfig.githubApiUrl + path),
      );
}

class DioInterceptor extends Interceptor {
  Box tokensBox = Hive.box('tokens');
  final GoogleSignIn googleSignIn = getIt<GoogleSignIn>();
  final Dio dio = Dio(BaseOptions(baseUrl: EnvironmentConfig.apiUrl));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ' + tokensBox.get('access');
    options.queryParameters['key'] = EnvironmentConfig.apiKey;

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if ((err.response?.statusCode ?? 401) == 401) {
      GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signInSilently();
      final String? accessToken =
          (await googleSignInAccount!.authentication).accessToken;
      await tokensBox.put('access', accessToken);

      err.requestOptions.headers['Authorization'] =
          'Bearer ' + tokensBox.get('access');

      final opts = Options(
        method: err.requestOptions.method,
        headers: err.requestOptions.headers,
      );

      final cloneReq = await dio.request(
        err.requestOptions.path,
        options: opts,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
      );

      return handler.resolve(cloneReq);
    }
    return super.onError(err, handler);
  }
}
