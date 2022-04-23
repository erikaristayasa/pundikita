import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_menu.dart';
import '../widgets/profile_top_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<ProfileBloc>(),
        ),
      ],
      child: SafeArea(
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
      ),
    );
  }
}
