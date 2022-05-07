import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/static/dimens.dart';
import 'package:pundi_kita/core/static/extensions.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../../core/static/colors.dart';
import '../../bloc/step/campaign_step_bloc.dart';
import '../../widgets/bottom_navbar_actions.dart';

class PersonalDataFormPage extends StatefulWidget {
  const PersonalDataFormPage({Key? key}) : super(key: key);

  @override
  State<PersonalDataFormPage> createState() => _PersonalDataFormPageState();
}

class _PersonalDataFormPageState extends State<PersonalDataFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _ktpNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _jobController = TextEditingController();
  final _workPlaceController = TextEditingController();
  final _facebookAccountController = TextEditingController();
  final _instagramAccountController = TextEditingController();
  final _twitterAccountController = TextEditingController();
  final _linkedInAccountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBarActions(
        onPrevious: () {
          context.read<CampaignStepBloc>().add(ToPreviousStep());
        },
        onNext: () {
          if (_formKey.currentState!.validate()) {
            context.read<CampaignStepBloc>().add(ToNextStep());
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimension.MEDIUM),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RoundedContainer(
                color: AppColors.SECONDARY.withOpacity(0.15),
                child: Text(
                  'Mohon lengkapi data personal Anda.',
                  style: context.textTheme().bodySmall,
                ),
              ),
              largeVerticalSpacing(),
              CustomTextField(
                title: 'Nama KTP',
                placeholder: 'Nama KTP',
                inputType: TextInputType.name,
                controller: _ktpNameController,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Nomor Telepon',
                placeholder: 'Nomor Telepon',
                inputType: TextInputType.phone,
                controller: _phoneController,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Pekerjaan/Kesibukan',
                placeholder: 'Pekerjaan/Kesibukan',
                inputType: TextInputType.none,
                controller: _jobController,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Nama Sekolah/Tempat Bekerja',
                placeholder: 'Nama Sekolah/Tempat Bekerja',
                inputType: TextInputType.none,
                controller: _workPlaceController,
              ),
              mediumVerticalSpacing(),
              const Divider(thickness: 1),
              CustomTextField(
                title: 'Facebook Akun',
                placeholder: 'Facebook Akun',
                inputType: TextInputType.none,
                controller: _facebookAccountController,
                validating: false,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Instagram Akun',
                placeholder: 'Instagram Akun',
                inputType: TextInputType.none,
                controller: _instagramAccountController,
                validating: false,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Twitter Akun',
                placeholder: 'Twitter Akun',
                inputType: TextInputType.none,
                controller: _twitterAccountController,
                validating: false,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Linked In Akun',
                placeholder: 'Linked In Akun',
                inputType: TextInputType.none,
                controller: _linkedInAccountController,
                validating: false,
              ),
              mediumVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}
