import 'package:bloc/bloc.dart';
import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/models/remote/github/release_model.dart';
import 'package:code_money/src/router/routing_const.dart';
import 'package:code_money/src/services/github/github_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Box tokensBox = Hive.box('tokens');
  final GoogleSignIn googleSignIn;
  final GithubService githubService;
  late PackageInfo packageInfo;

  AuthCubit({
    required this.googleSignIn,
    required this.githubService,
  }) : super(AuthInitial());

  void appStarted() async {
    packageInfo = await PackageInfo.fromPlatform();
    ReleaseModel releaseVersion = (await githubService.checkAppVersion()).first;

    if (releaseVersion.tagName != packageInfo.version) {
      if (!getIt.isRegistered<ReleaseModel>()) {
        getIt.registerLazySingleton<ReleaseModel>(() => releaseVersion);
      }
      emit(ForceUpdate());
      return;
    }

    tokensBox.get('access') == null
        ? emit(UnAuthenticated())
        : emit(Authenticated());
  }
}
