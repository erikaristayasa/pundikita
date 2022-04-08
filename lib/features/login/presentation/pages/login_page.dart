import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/login_bloc.dart';
import '../widgets/login_form.dart';
import '../widgets/login_social_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => locator<LoginBloc>(),
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: AppLocale.loc.loginPage,
            canBack: false,
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(Dimension.MEDIUM),
              children: [
                const LoginForm(),
                largeVerticalSpacing(),
                const Divider(
                  thickness: 2.0,
                ),
                largeVerticalSpacing(),
                Container(
                  height: 300,
                  color: Colors.white,
                  child: ListView(
                    children: [
                      LoginSocialButton(onTap: () {}, asset: Assets.GOOGLE, title: AppLocale.loc.loginWithGoogle),
                      mediumVerticalSpacing(),
                      LoginSocialButton(onTap: () {}, asset: Assets.FACEBOOK, title: AppLocale.loc.loginWithFacebook)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
