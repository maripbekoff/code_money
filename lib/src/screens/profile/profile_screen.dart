import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Профиль'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('Выйти'),
          onPressed: () async {
            await getIt<GoogleSignIn>().signOut();
            await Hive.box('tokens').delete('accessToken');
            Navigator.of(
              context,
              rootNavigator: true,
            ).popUntil((route) => route.isFirst);
          },
        ),
      ),
    );
  }
}
