import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pundi_kita/core/static/enums.dart';
import 'package:pundi_kita/core/static/extensions.dart';

import '../../../../../core/presentation/widgets/custom_birthdate_input.dart';
import '../../../../../core/presentation/widgets/custom_gender_selection.dart';
import '../../../../../core/presentation/widgets/custom_label.dart';
import '../../../../../core/presentation/widgets/custom_text_area.dart';
import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/utility/helper.dart';
import '../../cubit/additional_body_cubit.dart';
import '../register_photo_file_picker.dart';

class FoundationForm extends StatefulWidget {
  const FoundationForm({Key? key}) : super(key: key);

  @override
  State<FoundationForm> createState() => _FoundationFormState();
}

class _FoundationFormState extends State<FoundationForm> {
  final _foundationNameController = TextEditingController();
  final _foundationAddressController = TextEditingController();

  XFile? _foundationLicensePhoto, _foundationInChargePhoto;

  final _foundationInChargeKtpNumberController = TextEditingController();
  final _foundationInChargeKtpNameController = TextEditingController();
  final _foundationInChargeKtpBirthPlaceController = TextEditingController();
  final _foundationInChargeKtpBirthDateController = TextEditingController();
  Gender _foundationInChargeKtpGender = Gender.male;
  final _foundationInChargeKtpAddressController = TextEditingController();

  updateAdditonalValue() async {
    final _map = {
      if (_foundationLicensePhoto != null) 'foto_surat_izin_yayasan': await MultipartFile.fromFile(_foundationLicensePhoto!.path, filename: _foundationLicensePhoto!.name),
      if (_foundationInChargePhoto != null) 'foto_ktp_penanggung_jawab_yayasan': await MultipartFile.fromFile(_foundationInChargePhoto!.path, filename: _foundationInChargePhoto!.name),
      'nama_yayasan': _foundationNameController.text,
      'alamat_yayasan': _foundationAddressController.text,
      'nomor_ktp_penanggung_jawab_yayasan': _foundationInChargeKtpNumberController.text,
      'nama_ktp_penanggung_jawab_yayasan': _foundationInChargeKtpNameController.text,
      'tempat_lahir_ktp_penanggung_jawab_yayasan': _foundationInChargeKtpBirthPlaceController.text,
      'tanggal_lahir_ktp_penanggung_jawab_yayasan': _foundationInChargeKtpBirthDateController.text,
      'jenis_kelamin_ktp_penanggung_jawab_yayasan': _foundationInChargeKtpGender.getString(),
      'alamat_ktp_penanggung_jawab_yayasan': _foundationInChargeKtpAddressController.text
    };
    context.read<AdditionalBodyCubit>().setValue(_map);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          title: 'Nama Yayasan',
          placeholder: 'Nama Yayasan',
          inputType: TextInputType.name,
          controller: _foundationNameController,
          onChange: (_) => updateAdditonalValue(),
        ),
        smallVerticalSpacing(),
        CustomTextArea(
          title: 'Alamat Yayasan',
          placeholder: 'Alamat Yayasan',
          controller: _foundationAddressController,
          onChanged: (_) => updateAdditonalValue(),
        ),
        smallVerticalSpacing(),
        RegisterPhotoFilePicker(
          title: 'Foto Surat Izin Yayasan',
          onPicked: (file) {
            _foundationLicensePhoto = file;
            updateAdditonalValue();
          },
        ),
        mediumVerticalSpacing(),
        const CustomLabel(title: 'Penanggung Jawab Yayasan'),
        smallVerticalSpacing(),
        RegisterPhotoFilePicker(
          title: 'Foto KTP',
          onPicked: (file) {
            _foundationInChargePhoto = file;
            updateAdditonalValue();
          },
        ),
        smallVerticalSpacing(),
        CustomTextField(
          title: 'Nomor KTP',
          placeholder: 'Nomor KTP',
          inputType: TextInputType.number,
          controller: _foundationInChargeKtpNumberController,
          onChange: (_) => updateAdditonalValue(),
        ),
        smallVerticalSpacing(),
        CustomTextField(
          title: 'Nama KTP',
          placeholder: 'Nama KTP',
          inputType: TextInputType.name,
          controller: _foundationInChargeKtpNameController,
          onChange: (_) => updateAdditonalValue(),
        ),
        smallVerticalSpacing(),
        CustomTextField(
          title: 'Tempat Lahir KTP',
          placeholder: 'Tempat Lahir KTP',
          inputType: TextInputType.streetAddress,
          controller: _foundationInChargeKtpBirthPlaceController,
          onChange: (_) => updateAdditonalValue(),
        ),
        smallVerticalSpacing(),
        CustomBirthDateInput(
          title: 'Tanggal Lahir KTP',
          controller: _foundationInChargeKtpBirthDateController,
          birthDate: _foundationInChargeKtpBirthDateController.text.toDate(),
        ),
        smallVerticalSpacing(),
        CustomGenderSelection(
          title: 'Jenis Kelamin KTP',
          onChanged: (value) {
            setState(() {
              _foundationInChargeKtpGender = value;
              updateAdditonalValue();
            });
          },
          groupValue: _foundationInChargeKtpGender,
        ),
        smallVerticalSpacing(),
        CustomTextArea(
          title: 'Alamat KTP',
          placeholder: 'Alamat KTP',
          controller: _foundationInChargeKtpAddressController,
          onChanged: (_) => updateAdditonalValue(),
        )
      ],
    );
  }
}
