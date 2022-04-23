import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/setting_bloc.dart';
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
        BlocProvider(
          create: (context) => locator<SettingBloc>(),
        ),
      ],
      child: SafeArea(
        child: ColoredBox(
          color: AppColors.BG_Grey,
          child: Column(
            children: [
              const ProfileTopContainer(),
              smallVerticalSpacing(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: Dimension.MEDIUM),
                  shrinkWrap: true,
                  children: [
                    RoundedContainer(
                      child: ProfileMenu(
                        asset: Assets.FAQ,
                        onTap: () => Navigator.pushNamed(context, path.FAQ),
                        title: AppLocale.loc.faq,
                      ),
                    ),
                    smallVerticalSpacing(),
                    RoundedContainer(
                      radius: Dimension.MEDIUM,
                      child: Column(
                        children: [
                          ProfileMenu(
                            asset: Assets.ABOUT,
                            onTap: () {},
                            title: AppLocale.loc.about,
                          ),
                          const Divider(),
                          ProfileMenu(
                            asset: Assets.TERMS_AND_CONDITION,
                            onTap: () {},
                            title: AppLocale.loc.termsAndConditions,
                          ),
                          const Divider(),
                          ProfileMenu(
                            asset: Assets.PRIVACY_POLICY,
                            onTap: () {},
                            title: AppLocale.loc.privacyPolicy,
                          ),
                        ],
                      ),
                    ),
                    smallVerticalSpacing(),
                    RoundedContainer(
                      child: ProfileMenu(
                        asset: Assets.LOGOUT,
                        onTap: () {},
                        title: AppLocale.loc.logout,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
