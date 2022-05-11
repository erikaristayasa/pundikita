import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/features/profile/presentation/widgets/profile_setting_container.dart';

import '../../../../core/domain/entities/user_entity.dart';
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
import '../widgets/profile_menu.dart';
import '../widgets/profile_top_container.dart';

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
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        User? _data;
                        if (state is ProfileLoaded) {
                          _data = state.data;
                        }

                        return RoundedContainer(
                          child: ProfileMenu(
                            asset: Assets.WALLET,
                            onTap: () => Navigator.pushNamed(context, path.WALLET_TOP_UP),
                            title: 'Dompet',
                            subtitle: 'Saldo anda saat ini ${getFormattedPrice(_data?.saldo?.toInt() ?? 0)}',
                          ),
                        );
                      },
                    ),
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
