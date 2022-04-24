import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/presentation/widgets/custom_text_area.dart';
import 'package:pundi_kita/core/presentation/widgets/rounded_container.dart';
import 'package:pundi_kita/core/static/dimens.dart';
import 'package:pundi_kita/core/static/extensions.dart';
import 'package:pundi_kita/core/utility/locator.dart';
import 'package:pundi_kita/features/profile/presentation/bloc/profile_bloc.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key? key}) : super(key: key);

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  prepareControllerValue(User user) {
    final _user = user;

    _nameController.text = _user.name ?? '';
    _emailController.text = _user.email ?? '';
    _phoneController.text = _user.phone ?? '';
    _birthDateController.text = _user.birthDate?.toText() ?? '';
    _bioController.text = _user.biodata ?? '';
  }

  showBirthDatePicker(DateTime? birthDate) async {
    final now = DateTime.now();
    final firstDate = DateTime(1900);
    await showDatePicker(context: context, initialDate: birthDate ?? now, firstDate: firstDate, lastDate: now).then(
      (value) {
        if (value != null) {
          _birthDateController.text = value.toText();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ProfileBloc>()..add(FetchProfile()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: AppLocale.loc.updateProfile,
          canBack: true,
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
          if (state is ProfileLoaded) {
            prepareControllerValue(state.data);
          }
        }, builder: (context, state) {
          if (state is ProfileLoaded) {
            final _user = state.data;
            return ListView(
              padding: const EdgeInsets.all(Dimension.MEDIUM),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: Dimension.MEDIUM),
                  height: 130,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: CircleAvatar(
                        backgroundColor: AppColors.SECONDARY.withOpacity(0.15),
                      ),
                    ),
                  ),
                ),
                largeVerticalSpacing(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        title: 'Nama Lengkap',
                        placeholder: 'Nama Lengkap',
                        inputType: TextInputType.name,
                        controller: _nameController,
                      ),
                      mediumVerticalSpacing(),
                      CustomTextField(
                        enabled: false,
                        title: 'Email',
                        placeholder: 'Email',
                        inputType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      mediumVerticalSpacing(),
                      CustomTextField(
                        title: 'Nomor Telepon',
                        placeholder: 'Nomor Telepon',
                        inputType: TextInputType.phone,
                        controller: _phoneController,
                      ),
                      mediumVerticalSpacing(),
                      InkWell(
                        onTap: () => showBirthDatePicker(_user.birthDate),
                        child: RoundedContainer(
                          padding: const EdgeInsets.symmetric(horizontal: Dimension.MEDIUM),
                          color: Colors.grey[200]!,
                          height: 46.0,
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month),
                              mediumHorizontalSpacing(),
                              Expanded(
                                child: TextField(
                                  controller: _birthDateController,
                                  enabled: false,
                                  decoration: const InputDecoration(border: InputBorder.none),
                                ),
                              )
                              //
                            ],
                          ),
                        ),
                      ),
                      mediumVerticalSpacing(),
                      CustomTextArea(
                        title: 'Bio Singkat',
                        controller: _bioController,
                        fieldValidator: (_) => null,
                      ),
                      largeVerticalSpacing(),
                      RoundedButton(
                        title: 'Simpan',
                        onTap: () {},
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return const SizedBox.expand();
        }),
      ),
    );
  }
}
