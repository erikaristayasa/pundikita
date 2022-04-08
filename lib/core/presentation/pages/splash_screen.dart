import 'package:flutter/material.dart';

import '../../routes/path.dart' as path;
import '../../static/colors.dart';
import '../../utility/app_locale.dart';
import '../../utility/helper.dart';
import '../../utility/locator.dart';
import '../../utility/shared_preferences_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      final session = await locator.getAsync<SharedPreferencesHelper>();
      if (!session.isLoggedIn()) {
        Navigator.pushReplacementNamed(context, path.MAIN);
      } else {
        Navigator.pushReplacementNamed(context, path.LOGIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocale.setLoc = getLocalizationString(context);

    return const Scaffold(
      backgroundColor: AppColors.PRIMARY,
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
