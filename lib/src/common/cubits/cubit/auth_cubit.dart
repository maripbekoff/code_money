import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Box tokensBox = Hive.box('tokens');
  final GoogleSignIn googleSignIn;

  AuthCubit({
    required this.googleSignIn,
  }) : super(AuthInitial());

  void appStarted() async {
    print(tokensBox.get('access'));
    tokensBox.get('access') == null
        ? emit(UnAuthenticated())
        : emit(Authenticated());
  }
}
