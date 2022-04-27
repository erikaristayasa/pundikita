import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';

class LoginSocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String asset;
  final String title;
  const LoginSocialButton({Key? key, required this.onTap, required this.asset, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(Dimension.MEDIUM),
        shadow: true,
        child: Row(
          children: [
            Image.asset(
              asset,
              width: 24.0,
            ),
            mediumHorizontalSpacing(),
            Text(title),
          ],
        ),
      ),
    );
  }
}
