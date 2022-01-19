import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/common/widgets/app_text_field.dart';
import 'package:code_money/src/models/remote/articles/article_model.dart';
import 'package:code_money/src/models/remote/balance/balance_model.dart';
import 'package:code_money/src/models/remote/directions/direction_model.dart';
import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:code_money/src/screens/add_transaction/cubit/add_transaction_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController sumController = TextEditingController();
  TextEditingController walletController = TextEditingController();
  TextEditingController directionController = TextEditingController();
  TextEditingController counterAgentController = TextEditingController();
  TextEditingController appointmentController = TextEditingController();
  TextEditingController articleController = TextEditingController();

  List<ArticleModel> articles = getIt<List<ArticleModel>>();
  List<BalanceModel> balances = getIt<List<BalanceModel>>();
  List<DirectionModel> directions = getIt<List<DirectionModel>>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Добавить запись'),
      ),
      child: ListView(
        children: [
          AppTextField(
            controller: dateController,
            placeholder: 'Дата',
            readOnly: true,
            keyboardType: TextInputType.datetime,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  decoration: const BoxDecoration(
                    color: CupertinoColors.white,
                  ),
                  height: MediaQuery.of(context).size.height / 2,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    maximumDate: DateTime.now().add(const Duration(days: 365)),
                    minimumDate: DateTime.now().subtract(
                      const Duration(days: 1095),
                    ),
                    onDateTimeChanged: (date) {
                      setState(() {
                        dateController.text =
                            '${date.day}.${date.month}.${date.year}';
                      });
                    },
                  ),
                ),
              );
            },
          ),
          AppTextField(
            controller: sumController,
            placeholder: 'Сумма',
            maxLength: 20,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          AppTextField(
            controller: walletController,
            placeholder: 'Кошелек',
            readOnly: true,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: CupertinoColors.white,
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    child: CupertinoPicker.builder(
                      childCount: balances.length,
                      itemExtent: 60,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          walletController.text = balances[index].title;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Text(balances[index].title);
                      },
                    ),
                  );
                },
              );
            },
          ),
          AppTextField(
            controller: directionController,
            placeholder: 'Направление бизнеса',
            readOnly: true,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: CupertinoColors.white,
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    child: CupertinoPicker.builder(
                      childCount: directions.length,
                      itemExtent: 60,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          directionController.text = directions[index].title;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Text(directions[index].title);
                      },
                    ),
                  );
                },
              );
            },
          ),
          AppTextField(
            controller: counterAgentController,
            placeholder: 'Контрагент',
          ),
          AppTextField(
            controller: appointmentController,
            placeholder: 'Назначение платежа',
          ),
          AppTextField(
            controller: articleController,
            placeholder: 'Статья',
            readOnly: true,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: CupertinoColors.white,
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    child: CupertinoPicker.builder(
                      childCount: articles.length,
                      itemExtent: 60,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          articleController.text = articles[index].title;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Text(articles[index].title);
                      },
                    ),
                  );
                },
              );
            },
          ),
          BlocBuilder<AddTransactionCubit, AddTransactionState>(
            builder: (context, state) {
              return CupertinoButton.filled(
                child: const Text('Добавить'),
                onPressed: state is AddTransactionLoading
                    ? null
                    : () {
                        TransactionModel transaction = TransactionModel(
                          month: null,
                          monthNum: null,
                          date: dateController.text,
                          sum: int.parse(sumController.text),
                          wallet: walletController.text,
                          direction: directionController.text,
                          counterAgent: counterAgentController.text,
                          appointment: appointmentController.text,
                          article: articleController.text,
                          admission: null,
                          kindOfActivity: null,
                        );
                        context
                            .read<AddTransactionCubit>()
                            .addTransaction(transaction: transaction);
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}
