import 'package:code_money/src/router/routing_const.dart';
import 'package:code_money/src/screens/home/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('ДДС'),
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: context.read(),
        builder: (context, state) {
          if (state is HomeLoaded) {
            return Stack(
              children: [
                ListView(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.balances.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(state.balances[index].title),
                            const Spacer(),
                            Text('${state.balances[index].total}'),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Транзакции'),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.transactions.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(state.transactions[index].wallet),
                            const Spacer(),
                            Text('${state.transactions[index].sum}'),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(360),
                    child: const Icon(CupertinoIcons.add),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      RoutingConst.addTransactionRoute,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is NoPermissions) {
            return const Center(
              child: Text('У вас нет доступа к приложению!'),
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
