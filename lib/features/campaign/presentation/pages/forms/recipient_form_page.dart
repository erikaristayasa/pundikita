import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  final GlobalKey formKey;
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

  @override
  Widget build(BuildContext context) {
    return Form(
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
    );
  }
}

class FoundationRecipientForm extends StatelessWidget {
  final GlobalKey formKey;
  const FoundationRecipientForm({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimension.MEDIUM),
          child: Column(),
        ));
  }
}