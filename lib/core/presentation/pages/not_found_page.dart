import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pundi_kita/core/presentation/widgets/rounded_button.dart';
import 'package:pundi_kita/core/utility/app_locale.dart';

import '../../static/assets.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                Assets.LOTTIE_404,
                fit: BoxFit.fitWidth,
              ),
              RoundedButton(
                width: 100.0,
                onTap: () => Navigator.pop(context),
                title: AppLocale.loc.back,
              )
            ],
          ),
        ),
      ),
    );
  }
}
