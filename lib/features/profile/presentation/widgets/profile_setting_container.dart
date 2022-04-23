import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';
import '../bloc/setting_bloc.dart';
import '../pages/setting_detail_page.dart';
import 'profile_menu.dart';

class ProfileSettingContainer extends StatefulWidget {
  const ProfileSettingContainer({Key? key}) : super(key: key);

  @override
  State<ProfileSettingContainer> createState() => _ProfileSettingContainerState();
}

class _ProfileSettingContainerState extends State<ProfileSettingContainer> {
  @override
  void initState() {
    super.initState();
    context.read<SettingBloc>().add(FetchSetting());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is SettingLoaded) {
          final _data = state.data;
          return RoundedContainer(
            radius: Dimension.MEDIUM,
            child: Column(
              children: [
                ProfileMenu(
                  asset: Assets.ABOUT,
                  onTap: () => Navigator.pushNamed(
                    context,
                    path.SETTING_DETAIL,
                    arguments: SettingDetailPageRouteArguments(
                      title: AppLocale.loc.about,
                      content: _data.aboutUs,
                    ),
                  ),
                  title: AppLocale.loc.about,
                ),
                const Divider(),
                ProfileMenu(
                  asset: Assets.TERMS_AND_CONDITION,
                  onTap: () => Navigator.pushNamed(
                    context,
                    path.SETTING_DETAIL,
                    arguments: SettingDetailPageRouteArguments(
                      title: AppLocale.loc.termsAndConditions,
                      content: _data.termsAndCondition,
                    ),
                  ),
                  title: AppLocale.loc.termsAndConditions,
                ),
                const Divider(),
                ProfileMenu(
                  asset: Assets.PRIVACY_POLICY,
                  onTap: () => Navigator.pushNamed(
                    context,
                    path.SETTING_DETAIL,
                    arguments: SettingDetailPageRouteArguments(
                      title: AppLocale.loc.privacyPolicy,
                      content: _data.privacyPolicy,
                    ),
                  ),
                  title: AppLocale.loc.privacyPolicy,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
