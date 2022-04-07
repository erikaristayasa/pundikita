import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case LoginLoading:
            context.loaderOverlay.show();
            break;
          case LoginSuccess:
            Fluttertoast.showToast(msg: 'Login success');
            Navigator.pushReplacementNamed(context, path.MAIN);
            break;
          case LoginError:
            context.loaderOverlay.hide();
            Fluttertoast.showToast(msg: (state as LoginError).message);
            break;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              title: AppLocale.loc.email,
              placeholder: AppLocale.loc.email,
              controller: _emailController,
              fieldValidator: (_) => null,
            ),
            CustomTextField(
              title: AppLocale.loc.password,
              placeholder: AppLocale.loc.password,
              isSecure: true,
              controller: _passwordController,
              fieldValidator: (_) => null,
            ),
            mediumVerticalSpacing(),
            RoundedButton(
              title: AppLocale.loc.login,
              onTap: () => context.read<LoginBloc>().add(LoginSubmitted(
                    email: _emailController.text,
                    password: _passwordController.text,
                  )),
            ),
          ],
        );
      },
    );
  }
}
