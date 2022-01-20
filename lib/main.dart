import 'package:code_money/src/common/cubits/cubit/auth_cubit.dart';
import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/common/hive/hive_container.dart';
import 'package:code_money/src/router/router.dart';
import 'package:code_money/src/router/routing_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initHive();
  initGetIt();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        googleSignIn: getIt(),
      )..appStarted(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return CupertinoApp(
            theme: const CupertinoThemeData(
              brightness: Brightness.light,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: state is Authenticated
                ? RoutingConst.mainRoute
                : RoutingConst.authRoute,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
