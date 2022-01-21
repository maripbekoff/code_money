import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final GoogleSignIn googleSignIn;
  final Box tokensBox = Hive.box('tokens');

  LogInCubit({
    required this.googleSignIn,
  }) : super(LogInInitial());

  signIn() async {
    emit(LogInLoading());
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final String? accessToken =
          (await googleSignInAccount!.authentication).accessToken;
      await tokensBox.put('access', accessToken);
      emit(LogInLoaded());
    } catch (e) {
      emit(LogInFailed());
      rethrow;
    }
  }
}
