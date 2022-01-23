import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ExitAppModal extends StatelessWidget {
  const ExitAppModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Закрыть приложение?'),
      content: null,
      actions: [
        CupertinoButton(
          child: const Text('Нет'),
          onPressed: () {
            return Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: const Text(
            'Закрыть',
            style: TextStyle(
              color: CupertinoColors.systemRed,
            ),
          ),
          onPressed: () async {
            if (Platform.isAndroid) {
              return await SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
        ),
      ],
    );
  }
}
