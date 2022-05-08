import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pundi_kita/features/campaign/presentation/bloc/create/campaign_create_bloc.dart';

import '../../../../../core/presentation/widgets/custom_birthdate_input.dart';
import '../../../../../core/presentation/widgets/custom_gender_selection.dart';
import '../../../../../core/presentation/widgets/custom_text_area.dart';
import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/presentation/widgets/photo_file_picker.dart';
import '../../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../../core/static/colors.dart';
import '../../../../../core/static/dimens.dart';
import '../../../../../core/static/enums.dart';
import '../../../../../core/static/extensions.dart';
import '../../../../../core/utility/helper.dart';
import '../../bloc/step/campaign_step_bloc.dart';
import '../../widgets/bottom_navbar_actions.dart';

class RecipientFormPage extends StatefulWidget {
  const RecipientFormPage({Key? key}) : super(key: key);

  @override
  State<RecipientFormPage> createState() => _RecipientFormPageState();
}

class _RecipientFormPageState extends State<RecipientFormPage> {
  final _formKey = GlobalKey<FormState>();
  RecipientType _recipientType = RecipientType.personal;

  onDropDownSelect(RecipientType recipientType) {
    context.read<CampaignCreateBloc>().add(UpdateBody(
          body: {'tipe_penerima': recipientType.toInteger()},
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: BottomNavigationBarActions(
      //   onPrevious: () {
      //     context.read<CampaignStepBloc>().add(ToPreviousStep());
      //   },
      //   onNext: () {
      //     if (_formKey.currentState!.validate()) {
      //       context.read<CampaignStepBloc>().add(ToNextStep());
      //     }
      //   },
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimension.MEDIUM,
              left: Dimension.MEDIUM,
              right: Dimension.MEDIUM,
              bottom: Dimension.SMALL,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RoundedContainer(
                  color: AppColors.SECONDARY.withOpacity(0.15),
                  child: Text(
                    'Mohon lengkapi data penerima dana.',
                    style: context.textTheme().bodySmall,
                  ),
                ),
                mediumVerticalSpacing(),
                Text(
                  'Tipe Penerima',
                  style: context.textTheme().titleSmall,
                ),
                DropdownButtonFormField<RecipientType>(
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: InputBorder.none,
                    focusedBorder: inputFieldBorder,
                    enabledBorder: inputFieldBorder,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  value: _recipientType,
                  items: List<DropdownMenuItem<RecipientType>>.from(
                    RecipientType.values.map(
                      (e) => DropdownMenuItem<RecipientType>(
                        value: e,
                        child: Text(
                          e.getString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _recipientType = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
            child: _recipientType == RecipientType.personal ? PersonalRecipientForm(formKey: _formKey) : FoundationRecipientForm(formKey: _formKey),
          )
        ],
      ),
    );
  }
}

class PersonalRecipientForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const PersonalRecipientForm({Key? key, required this.formKey}) : super(key: key);

  @override
  State<PersonalRecipientForm> createState() => _PersonalRecipientFormState();
}

class _PersonalRecipientFormState extends State<PersonalRecipientForm> {
  XFile? _ktpPhoto;
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _ktpNumberController = TextEditingController();
  final _ktpNameController = TextEditingController();
  final _ktpBirthPlaceController = TextEditingController();
  final _ktpBirthDateController = TextEditingController();
  Gender _ktpGender = Gender.male;
  final _ktpAddressController = TextEditingController();

  Future<Map<String, dynamic>> mapValue() async => {
        'nama_penerima_personal': _nameController.text,
        'alamat_penerima_personal': _addressController.text,
        if (_ktpPhoto != null) 'foto_ktp_penerima_personal': await MultipartFile.fromFile(_ktpPhoto!.path, filename: _ktpPhoto!.name),
        'nomor_ktp_penerima_personal': _ktpNumberController.text,
        'nama_ktp_penerima_personal': _ktpNameController.text,
        'tempat_lahir_ktp_penerima_personal': _ktpBirthPlaceController.text,
        'tanggal_lahir_ktp_penerima_personal': _ktpBirthDateController.text,
        'jenis_kelamin_ktp_penerima_personal': _ktpGender.getString(),
        'alamat_ktp_penerima_personal': _ktpAddressController.text,
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
          if (widget.formKey.currentState!.validate()) {
            context.read<CampaignStepBloc>().add(ToNextStep());
            context.read<CampaignCreateBloc>().add(UpdateBody(body: await mapValue()));
          }
        },
      ),
      body: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimension.MEDIUM),
          child: Column(
            children: [
              CustomTextField(
                title: 'Nama Penerima',
                placeholder: 'Nama Penerima',
                inputType: TextInputType.name,
                controller: _nameController,
              ),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: "Alamat Penerima",
                placeholder: "Alamat Penerima",
                controller: _addressController,
                maxlines: 3,
              ),
              mediumVerticalSpacing(),
              PhotoFilePicker(
                title: 'Foto KTP Penerima',
                onPicked: (file) {
                  _ktpPhoto = file;
                },
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Nomor KTP Penerima',
                placeholder: 'Nomor KTP Penerima',
                inputType: TextInputType.number,
                controller: _ktpNumberController,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Nama KTP Penerima',
                placeholder: 'Nama KTP Penerima',
                inputType: TextInputType.name,
                controller: _ktpNameController,
              ),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: 'Alamat KTP Penerima',
                placeholder: 'Alamat KTP Penerima',
                inputType: TextInputType.streetAddress,
                controller: _ktpAddressController,
                maxlines: 3,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Tempat Lahir KTP Penerima',
                placeholder: 'Tempat Lahir KTP Penerima',
                inputType: TextInputType.streetAddress,
                controller: _ktpBirthPlaceController,
              ),
              mediumVerticalSpacing(),
              CustomBirthDateInput(
                title: "Tanggal Lahir KTP Penerima",
                birthDate: _ktpBirthDateController.text.toDate(),
                controller: _ktpBirthDateController,
              ),
              mediumVerticalSpacing(),
              CustomGenderSelection(
                title: 'Jenis Kelamin KTP',
                onChanged: (value) {
                  setState(() {
                    _ktpGender = value;
                  });
                },
                groupValue: _ktpGender,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoundationRecipientForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const FoundationRecipientForm({Key? key, required this.formKey}) : super(key: key);

  @override
  State<FoundationRecipientForm> createState() => _FoundationRecipientFormState();
}

class _FoundationRecipientFormState extends State<FoundationRecipientForm> {
  XFile? _foundationLicensePhoto, _foundationKtpPhoto;
  final _foundationNameController = TextEditingController();
  final _foundationAddressController = TextEditingController();
  final _foundationInChargeNameController = TextEditingController();

  final _foundationRecipientKtpNumberController = TextEditingController();
  final _foundationRecipientKtpNameController = TextEditingController();
  final _foundationRecipientKtpBirthPlaceController = TextEditingController();
  final _foundationRecipientKtpBirthDateController = TextEditingController();
  Gender _foundationRecipientKtpGender = Gender.male;
  final _foundationRecipientKtpAddressController = TextEditingController();

  Future<Map<String, dynamic>> mapValue() async => {
        'nama_penerima_yayasan': _foundationNameController.text,
        'nama_penanggung_jawab_penerima_yayasan': _foundationInChargeNameController.text,
        'alamat_penerima_yayasan': _foundationAddressController.text,
        if (_foundationLicensePhoto != null) 'foto_surat_izin_penerima_yayasan': await MultipartFile.fromFile(_foundationLicensePhoto!.path, filename: _foundationLicensePhoto!.name),
        if (_foundationKtpPhoto != null) 'foto_ktp_penerima_yayasan': await MultipartFile.fromFile(_foundationKtpPhoto!.path, filename: _foundationKtpPhoto!.name),
        'nomor_ktp_penerima_yayasan': _foundationRecipientKtpNumberController.text,
        'nama_ktp_penerima_yayasan': _foundationRecipientKtpNameController.text,
        'tempat_lahir_ktp_penerima_yayasan': _foundationRecipientKtpBirthPlaceController.text,
        'tanggal_lahir_ktp_penerima_yayasan': _foundationRecipientKtpBirthDateController.text,
        'jenis_kelamin_ktp_penerima_yayasan': _foundationRecipientKtpGender.getString(),
        'alamat_ktp_penerima_yayasan': _foundationRecipientKtpAddressController.text,
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
          if (widget.formKey.currentState!.validate()) {
            context.read<CampaignStepBloc>().add(ToNextStep());
            context.read<CampaignCreateBloc>().add(UpdateBody(body: await mapValue()));
          }
        },
      ),
      body: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimension.MEDIUM),
          child: Column(
            children: [
              CustomTextField(
                title: 'Nama Penerima Yayasan',
                placeholder: 'Nama Penerima Yayasan',
                inputType: TextInputType.name,
                controller: _foundationNameController,
              ),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: 'Alamat Penerima Yayasan',
                placeholder: 'Alamat Penerima Yayasan',
                inputType: TextInputType.streetAddress,
                controller: _foundationAddressController,
                maxlines: 3,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Nama Penanggung Jawab Yayasan',
                placeholder: 'Nama Penanggung Jawab Yayasan',
                inputType: TextInputType.name,
                controller: _foundationInChargeNameController,
              ),
              mediumVerticalSpacing(),
              PhotoFilePicker(
                onPicked: (file) {
                  _foundationLicensePhoto = file;
                },
                title: 'Foto Surat Izin Penerima Yayasan',
              ),
              mediumVerticalSpacing(),
              PhotoFilePicker(
                onPicked: (file) {
                  _foundationKtpPhoto = file;
                },
                title: 'Foto KTP Penerima Yayasan',
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Nomor KTP Penerima Yayasan',
                placeholder: 'Nomor KTP Penerima Yayasan',
                inputType: TextInputType.number,
                controller: _foundationRecipientKtpNumberController,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Nama KTP Penerima Yayasan',
                placeholder: 'Nama KTP Penerima Yayasan',
                inputType: TextInputType.name,
                controller: _foundationRecipientKtpNameController,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Tempat Lahir KTP Penerima Yayasan',
                placeholder: 'Tempat Lahir KTP Penerima Yayasan',
                inputType: TextInputType.streetAddress,
                controller: _foundationRecipientKtpBirthPlaceController,
              ),
              mediumVerticalSpacing(),
              CustomBirthDateInput(
                title: "Tanggal Lahir KTP Penerima Yayasan",
                birthDate: _foundationRecipientKtpBirthDateController.text.toDate(),
                controller: _foundationRecipientKtpBirthDateController,
              ),
              mediumVerticalSpacing(),
              CustomGenderSelection(
                title: 'Jenis Kelamin KTP Penerima Yayasan',
                onChanged: (value) {
                  setState(() {
                    _foundationRecipientKtpGender = value;
                  });
                },
                groupValue: _foundationRecipientKtpGender,
              ),
              CustomTextArea(
                title: 'Alamat KTP Penerima Yayasan',
                placeholder: 'Alamat KTP Penerima Yayasan',
                inputType: TextInputType.streetAddress,
                controller: _foundationRecipientKtpAddressController,
                maxlines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
