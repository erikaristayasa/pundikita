import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/presentation/widgets/custom_text_area.dart';
import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/presentation/widgets/photo_file_picker.dart';
import '../../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../../core/static/colors.dart';
import '../../../../../core/static/dimens.dart';
import '../../../../../core/static/enums.dart';
import '../../../../../core/static/extensions.dart';
import '../../../../../core/utility/helper.dart';
import '../../../../../core/utility/validation_helper.dart';
import '../../bloc/step/campaign_step_bloc.dart';
import '../../widgets/bottom_navbar_actions.dart';

class PatientFormPage extends StatefulWidget {
  const PatientFormPage({Key? key}) : super(key: key);

  @override
  State<PatientFormPage> createState() => _PatientFormPageState();
}

class _PatientFormPageState extends State<PatientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _patientSicknessController = TextEditingController();
  HospitalityStatus _hospitalityStatus = HospitalityStatus.inpatient;
  final _hospitalNameController = TextEditingController();
  final _treatmentEffortsController = TextEditingController();
  final _medicalFundSourceController = TextEditingController();
  XFile? _patientKtpPhoto, _patientMedicalCertificatePhoto, _patientMedicalResultPhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimension.MEDIUM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RoundedContainer(
                color: AppColors.SECONDARY.withOpacity(0.15),
                child: Text(
                  'Mohon lengkapi data diri pasien dan data pelengkap lainnya.',
                  style: context.textTheme().bodySmall,
                ),
              ),
              largeVerticalSpacing(),
              CustomTextField(
                title: 'Nama Pasien',
                placeholder: 'Nama Pasien',
                inputType: TextInputType.name,
                typeField: TypeField.name,
                controller: _patientNameController,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Penyakit Pasien',
                placeholder: 'Penyakit Pasien',
                controller: _patientSicknessController,
              ),
              mediumVerticalSpacing(),
              Text(
                'Status Rawat',
                style: context.textTheme().titleSmall,
              ),
              DropdownButtonFormField<HospitalityStatus>(
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
                value: _hospitalityStatus,
                items: List<DropdownMenuItem<HospitalityStatus>>.from(
                  HospitalityStatus.values.map(
                    (e) => DropdownMenuItem<HospitalityStatus>(
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
                    _hospitalityStatus = value!;
                  });
                },
              ),
              _hospitalityStatus == HospitalityStatus.inpatient
                  ? Column(
                      children: [
                        mediumVerticalSpacing(),
                        CustomTextField(
                          title: 'Nama Rumah Sakit',
                          placeholder: 'Nama Rumah Sakit',
                          controller: _hospitalNameController,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: 'Pengobatan Yang Sudah Dilakukan',
                placeholder: 'Pengobatan Yang Sudah Dilakukan',
                controller: _treatmentEffortsController,
              ),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: 'Sumber Dana Pengobatan',
                placeholder: 'Sumber Dana Pengobatan',
                controller: _medicalFundSourceController,
              ),
              mediumVerticalSpacing(),
              PhotoFilePicker(
                title: 'Foto KTP Pasien',
                onPicked: (file) {
                  _patientKtpPhoto = file;
                  // updateAdditonalValue();
                },
              ),
              mediumVerticalSpacing(),
              PhotoFilePicker(
                title: 'Foto Surat Keterangan Medis',
                onPicked: (file) {
                  _patientMedicalCertificatePhoto = file;
                  // updateAdditonalValue();
                },
              ),
              mediumVerticalSpacing(),
              PhotoFilePicker(
                title: 'Foto Surat Hasil Pemeriksaan',
                onPicked: (file) {
                  _patientMedicalResultPhoto = file;
                  // updateAdditonalValue();
                },
              ),
              mediumVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}
