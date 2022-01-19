import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/router/routing_const.dart';
import 'package:code_money/src/screens/auth/auth_screen.dart';
import 'package:code_money/src/screens/auth/cubit/log_in_cubit.dart';
import 'package:code_money/src/screens/home/cubit/home_cubit.dart';
import 'package:code_money/src/screens/home/home_screen.dart';
import 'package:code_money/src/screens/main/main_screen.dart';
import 'package:code_money/src/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutingConst.authRoute:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LogInCubit(
              googleSignIn: getIt(),
            ),
            child: const AuthScreen(),
          ),
        );
      case RoutingConst.mainRoute:
        return CupertinoPageRoute(builder: (context) => const MainScreen());
      case RoutingConst.homeRoute:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeCubit(
              spreadsheetService: getIt(),
            )..init(),
            child: const HomeScreen(),
          ),
        );
      case RoutingConst.profileRoute:
        return CupertinoPageRoute(builder: (context) => const ProfileScreen());
      case RoutingConst.addTransactionRoute:
        return CupertinoPageRoute(builder: (context) => const AuthScreen());
      default:
        return CupertinoPageRoute(builder: (context) => const AuthScreen());
    }
  }
}
