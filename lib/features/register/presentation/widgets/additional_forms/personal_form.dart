import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pundi_kita/core/presentation/widgets/custom_text_field.dart';
import 'package:pundi_kita/core/static/enums.dart';
import 'package:pundi_kita/core/utility/helper.dart';
import 'package:pundi_kita/features/register/presentation/widgets/register_photo_file_picker.dart';

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
  final _ktpGender = Gender.male;
  final _ktpAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RegisterPhotoFilePicker(
            title: 'Foto KTP',
            onPicked: (file) {
              _ktpPhoto = file;
              logMe(_ktpPhoto);
            },
          )
        ],
      ),
    );
  }
}
