import 'package:code_money/src/router/routing_const.dart';
import 'package:code_money/src/screens/auth/cubit/log_in_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Авторизация'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<LogInCubit, LogInState>(
              listener: (context, state) {
                if (state is LogInLoaded) {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushReplacementNamed(
                    RoutingConst.mainRoute,
                  );
                }
              },
              builder: (context, state) {
                return CupertinoButton.filled(
                  child: const Text('Войти'),
                  onPressed: state is LogInLoading
                      ? null
                      : () => context.read<LogInCubit>().signIn(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
