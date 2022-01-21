import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/models/local/router/add_transaction_screen_args.dart';
import 'package:code_money/src/router/routing_const.dart';
import 'package:code_money/src/screens/add_transaction/add_transaction_screen.dart';
import 'package:code_money/src/screens/add_transaction/cubit/add_transaction_cubit.dart';
import 'package:code_money/src/screens/auth/auth_screen.dart';
import 'package:code_money/src/screens/auth/cubit/log_in_cubit.dart';
import 'package:code_money/src/screens/force_update/force_update_screen.dart';
import 'package:code_money/src/screens/home/cubit/home_cubit.dart';
import 'package:code_money/src/screens/home/home_screen.dart';
import 'package:code_money/src/screens/main/main_screen.dart';
import 'package:code_money/src/screens/profile/profile_screen.dart';
import 'package:code_money/src/screens/splash/splash_screen.dart';
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
        AddTransactionScreenArgs args =
            routeSettings.arguments as AddTransactionScreenArgs;

        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AddTransactionCubit(
              spreadsheetService: getIt(),
            ),
            child: AddTransactionScreen(
              onCreated: args.onCreated,
            ),
          ),
        );
      case RoutingConst.forceUpdateRoute:
        return CupertinoPageRoute(
          builder: (context) => const ForceUpdateScreen(),
        );
      case RoutingConst.splashRoute:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );
      default:
        return CupertinoPageRoute(builder: (context) => const AuthScreen());
    }
  }
}
