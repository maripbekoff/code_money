import 'package:code_money/src/models/local/router/add_transaction_screen_args.dart';
import 'package:code_money/src/models/remote/balance/balance_model.dart';
import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:code_money/src/router/routing_const.dart';
import 'package:code_money/src/screens/home/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  late BalanceModel selectedBalance;
  late List<BalanceModel> filterBalances = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('ДДС'),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<HomeCubit, HomeState>(
          bloc: context.read(),
          listener: (context, state) {
            if (state is HomeLoaded) {
              filterBalances.clear();
              final totalBalance = BalanceModel(
                title: 'Все кошельки',
                total: state.totalBalance.total,
              );
              selectedBalance = totalBalance;
              filterBalances.add(totalBalance);
              filterBalances.addAll(state.balances);
            }
          },
          builder: (context, state) {
            if (state is HomeLoaded) {
              bool isSelectedAllWallets =
                  selectedBalance.title == 'Все кошельки';
              List<TransactionModel> transactionsFiltered = [];

              if (!isSelectedAllWallets) {
                transactionsFiltered = state.transactions
                    .where(
                      (t) => t.wallet == selectedBalance.title,
                    )
                    .toList();
              }

              return Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      bottom: 40,
                    ),
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedBalance,
                            items: filterBalances
                                .map(
                                  (e) => DropdownMenuItem<BalanceModel>(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e.title),
                                        Text('${e.total} тг'),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (BalanceModel? object) {
                              setState(() => selectedBalance = object!);
                            },
                            selectedItemBuilder: (context) {
                              return filterBalances
                                  .map(
                                    (e) => Center(
                                      child: Text(
                                        e.title,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Транзакции',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (state.transactions.isNotEmpty)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: isSelectedAllWallets
                              ? state.transactions.length
                              : transactionsFiltered.length,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 5),
                          itemBuilder: (context, index) {
                            TransactionModel transaction;

                            if (isSelectedAllWallets) {
                              transaction = state.transactions[index];
                            } else {
                              transaction = transactionsFiltered[index];
                            }

                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey6,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    transaction.wallet,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        '${transaction.isAdmission ?? false ? '+' : '-'} ${transaction.sum.abs()} ₸',
                                        style: TextStyle(
                                          color:
                                              transaction.isAdmission ?? false
                                                  ? CupertinoColors.activeGreen
                                                  : CupertinoColors.systemRed,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        transaction.date,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      if (!transactionsFiltered.isNotEmpty)
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                      if (!transactionsFiltered.isNotEmpty)
                        const Center(
                          child: Text(
                            'Записей не найдено!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Positioned(
                    bottom: 16,
                    right: 0,
                    child: CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(360),
                      child: const Icon(CupertinoIcons.add),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        RoutingConst.addTransactionRoute,
                        arguments: AddTransactionScreenArgs(
                          onCreated: () => context.read<HomeCubit>().init(),
                        ),
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
      ),
    );
  }
}
