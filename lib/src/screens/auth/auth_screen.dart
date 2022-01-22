import 'package:code_money/src/router/routing_const.dart';
import 'package:code_money/src/screens/auth/cubit/log_in_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: CupertinoPageScaffold(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 38),
              const Text(
                'Добро пожаловать!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 38),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Code Money - позволит записывать новые транзакции без входа в таблицу Excel, сэкономит твоё время и сделает тебя в следующий раз более предприимчивым.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 30,
                child: Image.asset(
                  'assets/images/add_transaction_screenshot.png',
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocConsumer<LogInCubit, LogInState>(
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
              ),
              const SizedBox(height: 38),
            ],
          ),
        ),
      ),
    );
  }
}
