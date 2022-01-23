import 'package:code_money/src/common/cubits/cubit/auth_cubit.dart';
import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/common/hive/hive_container.dart';
import 'package:code_money/src/router/router.dart';
import 'package:code_money/src/router/routing_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return BlocProvider(
      create: (context) => AuthCubit(
        googleSignIn: getIt(),
        githubService: getIt(),
      )..appStarted(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return buildApp(state.initialRoute);
          } else if (state is UnAuthenticated) {
            return buildApp(state.initialRoute);
          } else if (state is ForceUpdate) {
            return buildApp(state.initialRoute);
          }
          return buildApp(RoutingConst.splashRoute);
        },
      ),
    );
  }

  CupertinoApp buildApp(String initialRoute) {
    return CupertinoApp(
      key: Key(initialRoute),
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
