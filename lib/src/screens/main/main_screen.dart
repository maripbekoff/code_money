import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/common/widgets/modals/exit_app_modal.dart';
import 'package:code_money/src/router/router.dart';
import 'package:code_money/src/screens/home/cubit/home_cubit.dart';
import 'package:code_money/src/screens/home/home_screen.dart';
import 'package:code_money/src/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<GlobalKey<NavigatorState>> navigatorKeys = [];
  CupertinoTabController controller = CupertinoTabController(initialIndex: 0);
  int prevTabIndex = 0;

  @override
  void initState() {
    navigatorKeys = List.generate(
      2,
      (index) => GlobalKey<NavigatorState>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: CupertinoTabScaffold(
        controller: controller,
        tabBar: CupertinoTabBar(
          onTap: (int index) {
            onTap(index, context);

            prevTabIndex = index;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.money_dollar)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled)),
          ],
        ),
        tabBuilder: (context, index) {
          return SafeArea(
            top: false,
            child: CupertinoTabView(
              navigatorKey: navigatorKeys[index],
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

  void onTap(int index, BuildContext context) {
    if (prevTabIndex == index) {
      Navigator.popUntil(
        navigatorKeys[index].currentContext ?? context,
        (route) {
          if (route.settings.name != '/') {
            return route.settings.name == '/';
          } else {
            return true;
          }
        },
      );
    }
  }

  Future<bool> onWillPop() async {
    String currentRoute = '/';

    navigatorKeys[controller.index].currentState!.popUntil((route) {
      currentRoute = route.settings.name ?? '';
      return true;
    });

    if (currentRoute == '/') {
      Future<bool> isPopped = await showCupertinoModalPopup(
        context: context,
        builder: (_) => const ExitAppModal(),
      );
      return isPopped;
    } else {
      return !await navigatorKeys[controller.index].currentState!.maybePop();
    }
  }
}
