import 'package:flutter/material.dart';

import '../../../../core/static/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ColoredBox(
        color: AppColors.PRIMARY,
        child: SizedBox.expand(),
      ),
    );
  }
}
