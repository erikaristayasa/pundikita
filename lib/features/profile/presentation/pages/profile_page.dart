import 'package:flutter/material.dart';
import 'package:pundi_kita/core/presentation/widgets/rounded_button.dart';
import 'package:pundi_kita/core/static/assets.dart';
import 'package:pundi_kita/core/static/dimens.dart';
import 'package:pundi_kita/core/static/extensions.dart';
import 'package:pundi_kita/core/utility/app_locale.dart';
import 'package:pundi_kita/core/utility/helper.dart';
import 'package:pundi_kita/features/profile/presentation/widgets/profile_menu.dart';
import 'package:pundi_kita/features/profile/presentation/widgets/profile_top_container.dart';

import '../../../../core/static/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: AppColors.BG_Grey,
        child: ListView(
          children: [
            const ProfileTopContainer(),
            smallVerticalSpacing(),
            ProfileMenu(
              asset: Assets.ABOUT,
              onTap: () {},
              title: AppLocale.loc.about,
            ),
            smallVerticalSpacing(),
            ProfileMenu(
              asset: Assets.FAQ,
              onTap: () {},
              title: AppLocale.loc.faq,
            ),
            smallVerticalSpacing(),
            ProfileMenu(
              asset: Assets.TERMS_AND_CONDITION,
              onTap: () {},
              title: AppLocale.loc.termsAndConditions,
            ),
            smallVerticalSpacing(),
            ProfileMenu(
              asset: Assets.PRIVACY_POLICY,
              onTap: () {},
              title: AppLocale.loc.privacyPolicy,
            ),
            smallVerticalSpacing(),
            ProfileMenu(
              asset: Assets.LOGOUT,
              onTap: () {},
              title: AppLocale.loc.logout,
            ),
          ],
        ),
      ),
    );
  }
}
