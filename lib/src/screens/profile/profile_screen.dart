import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_money/environment_config.dart';
import 'package:code_money/src/common/dependencies/injection_container.dart';
import 'package:code_money/src/models/local/user/user_model.dart';
import 'package:code_money/src/router/routing_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Box tokensBox = Hive.box('tokens');
  final UserModel googleSignInAccount = Hive.box('user').get('googleAccount');

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Профиль'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(240),
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: googleSignInAccount.photoUrl,
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              googleSignInAccount.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              googleSignInAccount.email,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.systemGrey,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoButton(
                child: const Text('Открыть в Github'),
                onPressed: () {
                  launch(
                    'https://github.com/' +
                        EnvironmentConfig.githubUsername +
                        '/' +
                        EnvironmentConfig.repositoryName +
                        '/releases',
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoButton.filled(
                child: const Text('Выйти'),
                onPressed: () async {
                  await tokensBox.delete('access');
                  await Hive.box('user').delete('googleAccount');
                  await getIt<GoogleSignIn>().signOut();

                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamedAndRemoveUntil(
                    RoutingConst.authRoute,
                    (route) => route.isFirst,
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
