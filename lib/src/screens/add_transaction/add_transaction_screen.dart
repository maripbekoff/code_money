import 'package:flutter/cupertino.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Добавить запись'),
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
