import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/simple_alert_dialog.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../../../../core/utility/validation_helper.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: AppLocale.loc.forgotPassword,
          canBack: true,
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(Dimension.MEDIUM),
            children: [
              BlocProvider(
                create: (_) => locator<ForgotPasswordBloc>(),
                child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    switch (state.runtimeType) {
                      case ForgotPasswordLoading:
                        context.loaderOverlay.show();
                        break;
                      case ForgotPasswordSuccess:
                        context.loaderOverlay.hide();
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => SimpleAlertDialog(
                            title: AppLocale.loc.success,
                            message: AppLocale.loc.forgotPasswordSuccess,
                          ),
                        );

                        break;
                      case ForgotPasswordError:
                        context.loaderOverlay.hide();
                        showDialog(
                          context: context,
                          builder: (context) => SimpleAlertDialog(
                            title: AppLocale.loc.failure,
                            message: (state as ForgotPasswordError).message,
                          ),
                        );
                        break;
                    }
                  },
                  builder: ((context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            title: AppLocale.loc.email,
                            placeholder: AppLocale.loc.email,
                            inputType: TextInputType.emailAddress,
                            typeField: TypeField.email,
                            controller: _emailController,
                          ),
                          mediumVerticalSpacing(),
                          RoundedButton(
                            title: AppLocale.loc.send,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ForgotPasswordBloc>().add(ForgotPasswordSubmitted(email: _emailController.text));
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
