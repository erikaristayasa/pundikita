import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/features/profile/presentation/widgets/profile_setting_container.dart';

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
                    const ProfileSettingContainer(),
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
