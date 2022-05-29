import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/validation_helper.dart';

class RegisterPasswordContainer extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  const RegisterPasswordContainer({
    Key? key,
    required this.passwordController,
    required this.passwordConfirmationController,
  }) : super(key: key);

  @override
  State<RegisterPasswordContainer> createState() => _RegisterPasswordContainerState();
}

class _RegisterPasswordContainerState extends State<RegisterPasswordContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          title: AppLocale.loc.password,
          placeholder: AppLocale.loc.password,
          inputType: TextInputType.visiblePassword,
          typeField: TypeField.password,
          isSecure: true,
          onChange: (_) {
            setState(() {});
          },
          controller: widget.passwordController,
        ),
        mediumVerticalSpacing(),
        CustomTextField(
          title: AppLocale.loc.passwordConfirmation,
          placeholder: AppLocale.loc.passwordConfirmation,
          inputType: TextInputType.visiblePassword,
          typeField: TypeField.confirmationPassword,
          isSecure: true,
          onChange: (_) {
            setState(() {});
          },
          controller: widget.passwordConfirmationController,
          controllerMatcher: widget.passwordController,
        ),
      ],
    );
  }
}
