import 'package:flutter/material.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../static/assets.dart';
import '../../utility/app_locale.dart';
import '../widgets/rounded_button.dart';

class WorkInProgressPage extends StatelessWidget {
  final bool enableBack;
  const WorkInProgressPage({Key? key, this.enableBack = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.WORK_IN_PROGRESS,
                fit: BoxFit.fitWidth,
                width: 150,
              ),
              mediumVerticalSpacing(),
              enableBack
                  ? RoundedButton(
                      width: 100.0,
                      onTap: () => Navigator.pop(context),
                      title: AppLocale.loc.back,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
