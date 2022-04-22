import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../static/assets.dart';
import '../../utility/app_locale.dart';
import '../widgets/rounded_button.dart';

class NotFoundPage extends StatelessWidget {
  final bool enableBack;
  const NotFoundPage({Key? key, this.enableBack = true}) : super(key: key);

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
              enableBack
                  ? RoundedButton(
                      width: 100.0,
                      onTap: () => Navigator.pop(context),
                      title: AppLocale.loc.back,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
