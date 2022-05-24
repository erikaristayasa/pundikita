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
import '../../../../core/utility/shared_preferences_helper.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/setting_bloc.dart';
import '../widgets/profile_account_verification_status.dart';
import '../widgets/profile_menu.dart';
import '../widgets/profile_setting_container.dart';
import '../widgets/profile_top_container.dart';
import '../widgets/profile_wallet.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<ProfileBloc>()..add(FetchProfile()),
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
                    const ProfileAccountVerificationStatus(),
                    smallVerticalSpacing(),
                    const ProfileWallet(),
                    smallVerticalSpacing(),
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
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(AppLocale.loc.logout),
                            content: Text(
                              AppLocale.loc.areYouSureWantToLogOut,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(AppLocale.loc.cancel),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final session = await locator.getAsync<SharedPreferencesHelper>();
                                  await session.logOut().then(
                                        (_) => Navigator.pushNamedAndRemoveUntil(context, path.LOGIN, (route) => false),
                                      );
                                },
                                child: Text(AppLocale.loc.ok),
                              )
                            ],
                          ),
                        ),
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
