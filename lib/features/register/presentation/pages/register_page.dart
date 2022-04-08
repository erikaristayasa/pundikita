import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pundi_kita/core/presentation/widgets/custom_app_bar.dart';
import 'package:pundi_kita/core/utility/app_locale.dart';
import 'package:pundi_kita/features/register/presentation/widgets/register_form.dart';

import '../../../../core/static/dimens.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: AppLocale.loc.registerPage,
          canBack: true,
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(Dimension.MEDIUM),
            children: const [RegisterForm()],
          ),
        ),
      ),
    );
  }
}
