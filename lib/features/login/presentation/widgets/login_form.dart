import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pundi_kita/core/static/colors.dart';
import 'package:pundi_kita/core/utility/validation_helper.dart';

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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case LoginLoading:
            context.loaderOverlay.show();
            break;
          case LoginSuccess:
            Fluttertoast.showToast(msg: AppLocale.loc.loginSuccess);
            Navigator.pushReplacementNamed(context, path.MAIN);
            break;
          case LoginError:
            context.loaderOverlay.hide();
            Fluttertoast.showToast(msg: (state as LoginError).message);
            break;
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                title: AppLocale.loc.email,
                placeholder: AppLocale.loc.email,
                controller: _emailController,
                inputType: TextInputType.emailAddress,
                typeField: TypeField.email,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: AppLocale.loc.password,
                placeholder: AppLocale.loc.password,
                isSecure: true,
                controller: _passwordController,
                inputType: TextInputType.visiblePassword,
                typeField: TypeField.password,
              ),
              smallVerticalSpacing(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(primary: AppColors.PRIMARY),
                    onPressed: () {},
                    child: Text(AppLocale.loc.forgotPassword),
                  ),
                ],
              ),
              smallVerticalSpacing(),
              RoundedButton(
                title: AppLocale.loc.login,
                height: 54,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ));
                  }
                },
              ),
              mediumVerticalSpacing(),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocale.loc.dontHaveAnAccountYet),
                  TextButton(
                    style: TextButton.styleFrom(primary: AppColors.PRIMARY),
                    onPressed: () => Navigator.pushNamed(context, path.REGISTER),
                    child: Text(AppLocale.loc.register),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
