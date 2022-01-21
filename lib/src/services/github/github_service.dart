import 'package:code_money/environment_config.dart';
import 'package:code_money/src/common/dio/app_dio.dart';
import 'package:code_money/src/models/remote/github/release_model.dart';
import 'package:dio/dio.dart';

abstract class GithubService {
  Future<List<ReleaseModel>> checkAppVersion();
}

class GithubServiceImpl implements GithubService {
  late Dio dio;

  GithubServiceImpl({required GithubDio githubDio}) {
    githubDio.path =
        'repos/${EnvironmentConfig.githubUsername}/${EnvironmentConfig.repositoryName}/releases';
    dio = githubDio.dio;
  }

  @override
  Future<List<ReleaseModel>> checkAppVersion() async {
    try {
      Response res = await dio.get('');

      return (res.data as List).map((e) => ReleaseModel.fromJson(e)).toList();
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
