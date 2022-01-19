import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/router/router.dart';
import 'package:code_money/src/screens/home/cubit/home_cubit.dart';
import 'package:code_money/src/screens/home/home_screen.dart';
import 'package:code_money/src/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.money_dollar)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled)),
          ],
        ),
        tabBuilder: (context, index) {
          return SafeArea(
            top: false,
            child: CupertinoTabView(
              onGenerateRoute: AppRouter.onGenerateRoute,
              builder: (context) {
                switch (index) {
                  case 0:
                    return BlocProvider(
                      create: (context) => HomeCubit(
                        spreadsheetService: getIt(),
                      ),
                      child: const HomeScreen(),
                    );
                  case 1:
                    return const ProfileScreen();
                  default:
                    return Container();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
