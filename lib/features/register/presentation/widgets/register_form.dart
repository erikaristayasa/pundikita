import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/presentation/widgets/custom_label.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/photo_file_picker.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/simple_alert_dialog.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/validation_helper.dart';
import '../bloc/register_bloc.dart';
import '../cubit/additional_body_cubit.dart';
import '../cubit/donature_type_cubit.dart';
import 'register_additional_form.dart';
import 'register_donature_type_dropdown.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  XFile? _photo;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _additionalBody = {};

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case RegisterLoading:
                context.loaderOverlay.show();
                break;
              case RegisterSuccess:
                context.loaderOverlay.hide();
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => SimpleAlertDialog(
                    title: AppLocale.loc.success,
                    message: AppLocale.loc.registerSuccess,
                  ),
                );
                break;
              case RegisterError:
                context.loaderOverlay.hide();
                showDialog(
                  context: context,
                  builder: (context) => SimpleAlertDialog(
                    title: AppLocale.loc.failure,
                    message: (state as RegisterError).message,
                  ),
                );
                break;
            }
          },
        ),
        BlocListener<AdditionalBodyCubit, Map<String, dynamic>>(
          listener: (context, state) {
            _additionalBody = state;
            logMe(_additionalBody);
          },
        ),
      ],
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomLabel(title: "Data Pribadi"),
                smallVerticalSpacing(),
                PhotoFilePicker(
                  title: 'Foto',
                  validation: true,
                  onPicked: (file) {
                    _photo = file;
                  },
                ),
                mediumVerticalSpacing(),
                CustomTextField(
                  title: AppLocale.loc.name,
                  placeholder: AppLocale.loc.name,
                  inputType: TextInputType.emailAddress,
                  typeField: TypeField.name,
                  controller: _nameController,
                ),
                mediumVerticalSpacing(),
                CustomTextField(
                  title: AppLocale.loc.email,
                  placeholder: AppLocale.loc.email,
                  inputType: TextInputType.emailAddress,
                  typeField: TypeField.email,
                  controller: _emailController,
                ),
                mediumVerticalSpacing(),
                CustomTextField(
                  title: AppLocale.loc.phone,
                  placeholder: AppLocale.loc.phone,
                  inputType: TextInputType.phone,
                  typeField: TypeField.phone,
                  controller: _phoneController,
                ),
                mediumVerticalSpacing(),
                CustomTextField(
                  title: AppLocale.loc.password,
                  placeholder: AppLocale.loc.password,
                  inputType: TextInputType.visiblePassword,
                  typeField: TypeField.password,
                  isSecure: true,
                  controller: _passwordController,
                ),
                mediumVerticalSpacing(),
                CustomTextField(
                  title: AppLocale.loc.passwordConfirmation,
                  placeholder: AppLocale.loc.passwordConfirmation,
                  inputType: TextInputType.visiblePassword,
                  typeField: TypeField.confirmationPassword,
                  isSecure: true,
                  controller: _passwordConfirmationController,
                  controllerMatcher: _passwordController,
                ),
                mediumVerticalSpacing(),
                const Divider(thickness: 1.0),
                mediumVerticalSpacing(),
                const CustomLabel(title: 'Data Untuk Verifikasi Akun'),
                smallVerticalSpacing(),
                const RegisterDonatureTypeDropDown(),
                mediumVerticalSpacing(),
                const RegisterAdditionalForm(),
                mediumVerticalSpacing(),
                RoundedButton(
                  title: AppLocale.loc.register,
                  onTap: () {
                    logMe(_additionalBody);
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterBloc>().add(
                            RegisterSubmit(
                              photo: _photo!,
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              password: _passwordController.text,
                              passwordConfirmation: _passwordConfirmationController.text,
                              donatureType: context.read<DonatureTypeCubit>().state.toInteger(),
                              additonalBody: _additionalBody,
                            ),
                          );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
