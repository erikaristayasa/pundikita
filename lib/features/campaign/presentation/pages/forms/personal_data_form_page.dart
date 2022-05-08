import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/static/dimens.dart';
import 'package:pundi_kita/core/static/extensions.dart';
import 'package:pundi_kita/core/utility/helper.dart';
import 'package:pundi_kita/features/campaign/presentation/bloc/create/campaign_create_bloc.dart';

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

  Future<Map<String, dynamic>> mapValue() async => {
        'nama_ktp': _ktpNameController.text,
        'telepon': _phoneController.text,
        'pekerjaan': _jobController.text,
        'nama_sekolah_atau_tempat_kerja': _workPlaceController.text,
        if (_facebookAccountController.text.isNotEmpty) 'link_akun_facebook': _facebookAccountController.text,
        if (_instagramAccountController.text.isNotEmpty) 'link_akun_instagram': _instagramAccountController.text,
        if (_twitterAccountController.text.isNotEmpty) 'link_akun_twitter': _twitterAccountController.text,
        if (_linkedInAccountController.text.isNotEmpty) 'link_akun_linkedin': _linkedInAccountController.text,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBarActions(
        onPrevious: () {
          context.read<CampaignStepBloc>().add(ToPreviousStep());
        },
        onNext: () async {
          if (_formKey.currentState!.validate()) {
            context.read<CampaignStepBloc>().add(ToNextStep());
            context.read<CampaignCreateBloc>().add(UpdateBody(body: await mapValue()));
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
                inputType: TextInputType.text,
                controller: _jobController,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Nama Sekolah/Tempat Bekerja',
                placeholder: 'Nama Sekolah/Tempat Bekerja',
                inputType: TextInputType.text,
                controller: _workPlaceController,
              ),
              mediumVerticalSpacing(),
              const Divider(thickness: 1),
              CustomTextField(
                title: 'Facebook Akun',
                placeholder: 'www.facebook.com/[username]',
                inputType: TextInputType.url,
                controller: _facebookAccountController,
                validating: false,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Instagram Akun',
                placeholder: 'www.instagram.com/[username]',
                inputType: TextInputType.url,
                controller: _instagramAccountController,
                validating: false,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Twitter Akun',
                placeholder: 'www.twitter.com/[username]',
                inputType: TextInputType.url,
                controller: _twitterAccountController,
                validating: false,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Linked In Akun',
                placeholder: 'www.linkedin.com/in/[username]',
                inputType: TextInputType.url,
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
