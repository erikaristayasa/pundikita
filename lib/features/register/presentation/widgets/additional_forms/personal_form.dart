import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/presentation/widgets/custom_birthdate_input.dart';
import '../../../../../core/presentation/widgets/custom_gender_selection.dart';
import '../../../../../core/presentation/widgets/custom_text_area.dart';
import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/presentation/widgets/photo_file_picker.dart';
import '../../../../../core/static/enums.dart';
import '../../../../../core/static/extensions.dart';
import '../../../../../core/utility/helper.dart';
import '../../cubit/additional_body_cubit.dart';

class PersonalForm extends StatefulWidget {
  const PersonalForm({Key? key}) : super(key: key);

  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  XFile? _ktpPhoto;
  final _ktpNumberController = TextEditingController();
  final _ktpNameController = TextEditingController();
  final _ktpBirthPlaceController = TextEditingController();
  final _ktpBirthDateController = TextEditingController();
  Gender _ktpGender = Gender.male;
  final _ktpAddress = TextEditingController();

  updateAdditonalValue() async {
    final _map = {
      // if (_ktpPhoto != null) 'foto_ktp': await MultipartFile.fromFile(_ktpPhoto!.path, filename: _ktpPhoto!.name),
      if (_ktpPhoto != null) 'foto_ktp': _ktpPhoto,
      'nomor_ktp': _ktpNumberController.text,
      'nama_ktp': _ktpNameController.text,
      'tempat_lahir_ktp': _ktpBirthPlaceController.text,
      'tanggal_lahir_ktp': _ktpBirthDateController.text,
      'jenis_kelamin_ktp': _ktpGender.getString(),
      'alamat_ktp': _ktpAddress.text,
    };
    context.read<AdditionalBodyCubit>().setValue(_map);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhotoFilePicker(
          title: 'Foto KTP',
          onPicked: (file) {
            _ktpPhoto = file;
            logMe(_ktpPhoto);
            updateAdditonalValue();
          },
        ),
        smallVerticalSpacing(),
        CustomTextField(
          title: 'Nomor KTP',
          placeholder: 'Nomor KTP',
          inputType: TextInputType.number,
          controller: _ktpNumberController,
          onChange: (_) => updateAdditonalValue(),
        ),
        smallVerticalSpacing(),
        CustomTextField(
          title: 'Nama KTP',
          placeholder: 'Nama KTP',
          inputType: TextInputType.name,
          controller: _ktpNameController,
          onChange: (_) => updateAdditonalValue(),
        ),
        smallVerticalSpacing(),
        CustomTextField(
          title: 'Tempat Lahir KTP',
          placeholder: 'Tempat Lahir KTP',
          inputType: TextInputType.streetAddress,
          controller: _ktpBirthPlaceController,
          onChange: (_) => updateAdditonalValue(),
        ),
        smallVerticalSpacing(),
        CustomBirthDateInput(
          title: 'Tanggal Lahir KTP',
          controller: _ktpBirthDateController,
          birthDate: _ktpBirthDateController.text.toDate(),
        ),
        smallVerticalSpacing(),
        CustomGenderSelection(
          title: 'Jenis Kelamin KTP',
          onChanged: (value) {
            setState(() {
              _ktpGender = value;
              updateAdditonalValue();
            });
          },
          groupValue: _ktpGender,
        ),
        smallVerticalSpacing(),
        CustomTextArea(
          title: 'Alamat KTP',
          placeholder: 'Alamat KTP',
          controller: _ktpAddress,
          onChanged: (_) => updateAdditonalValue(),
        )
      ],
    );
  }
}
