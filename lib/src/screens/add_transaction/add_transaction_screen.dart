import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/common/widgets/app_text_field.dart';
import 'package:code_money/src/common/widgets/modals/picker_with_search_field.dart';
import 'package:code_money/src/models/remote/articles/article_model.dart';
import 'package:code_money/src/models/remote/balance/balance_model.dart';
import 'package:code_money/src/models/remote/directions/direction_model.dart';
import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:code_money/src/screens/add_transaction/cubit/add_transaction_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:hive/hive.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({
    Key? key,
    required this.onCreated,
  }) : super(key: key);

  final VoidCallback onCreated;

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

  final DateTime dateTimeNow = DateTime.now();
  final Box transactionsBox = Hive.box('transactions');

  @override
  void initState() {
    dateController.text =
        '${dateTimeNow.day}.${dateTimeNow.month}.${dateTimeNow.year}';
    walletController.text = transactionsBox.get('wallet') ?? '';
    directionController.text = transactionsBox.get('direction') ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Добавить транзакцию'),
      ),
      child: ListView(
        children: [
          Form(
            autovalidateMode: AutovalidateMode.always,
            onChanged: () {
              Form.of(primaryFocus!.context!)?.save();
            },
            child: CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.all(20),
              children: [
                AppTextFieldFormRow(
                  prefix: const Text('Дата'),
                  controller: dateController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста выберите дату';
                    }
                    return null;
                  },
                  placeholder:
                      '${dateTimeNow.day}.${dateTimeNow.month}.${dateTimeNow.year}',
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
                          maximumDate:
                              DateTime.now().add(const Duration(days: 365)),
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
                AppTextFieldFormRow(
                  prefix: const Text('Сумма'),
                  controller: sumController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста введите сумму транзакции';
                    }
                    return null;
                  },
                  placeholder: '30,000.00',
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MoneyInputFormatter(),
                  ],
                ),
                AppTextFieldFormRow(
                  prefix: const Text('Кошелек'),
                  controller: walletController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста выберите кошелек';
                    }
                    return null;
                  },
                  placeholder: 'Kaspi/Альфа',
                  readOnly: true,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return PickerWithSearchField(
                          list: balances.map((e) => e.title).toList(),
                          onSelectedItemChanged: (title) {
                            setState(() {
                              walletController.text = title;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
                AppTextFieldFormRow(
                  prefix: const Text('Направление'),
                  controller: directionController,
                  placeholder: 'Отдел Mobile',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста выберите направление';
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return PickerWithSearchField(
                          list: directions.map((e) => e.title).toList(),
                          onSelectedItemChanged: (title) {
                            setState(() {
                              directionController.text = title;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
                AppTextFieldFormRow(
                  prefix: const Text('Контрагент'),
                  controller: counterAgentController,
                  placeholder: 'Кирилл Хён',
                ),
                AppTextFieldFormRow(
                  prefix: const Text('Назначение'),
                  controller: appointmentController,
                  placeholder: 'Оплата за таргет',
                ),
                AppTextFieldFormRow(
                  prefix: const Text('Статья'),
                  controller: articleController,
                  placeholder: 'Доход - поступление',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста выберите статью';
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return PickerWithSearchField(
                          list: articles.map((e) => e.title).toList(),
                          onSelectedItemChanged: (title) {
                            setState(() {
                              articleController.text = title;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocConsumer<AddTransactionCubit, AddTransactionState>(
              listener: (context, state) {
                if (state is AddTransactionLoaded) {
                  widget.onCreated();
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return CupertinoButton.filled(
                  child: const Text('Добавить'),
                  onPressed: state is AddTransactionLoading
                      ? null
                      : () {
                          bool isValid =
                              Form.of(primaryFocus!.context!)?.validate() ??
                                  false;

                          if (isValid) {
                            TransactionModel transaction = TransactionModel(
                              month: null,
                              monthNum: null,
                              date:
                                  dateFromStringToDateTime(dateController.text),
                              sum: double.tryParse(
                                      sumController.text.replaceAll(',', '')) ??
                                  0,
                              wallet: walletController.text,
                              direction: directionController.text,
                              counterAgent: counterAgentController.text,
                              appointment: appointmentController.text,
                              article: articleController.text,
                              isAdmission: null,
                              kindOfActivity: null,
                            );
                            context
                                .read<AddTransactionCubit>()
                                .addTransaction(transaction: transaction);
                          }
                        },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
