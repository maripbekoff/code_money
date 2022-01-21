import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          width: MediaQuery.of(context).size.width / 2,
        ),
      ),
    );
  }
}
