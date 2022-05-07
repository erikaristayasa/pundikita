import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pundi_kita/core/presentation/widgets/custom_text_area.dart';
import 'package:pundi_kita/core/static/dimens.dart';

import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/presentation/widgets/photo_file_picker.dart';
import '../../../../../core/utility/helper.dart';
import '../../bloc/step/campaign_step_bloc.dart';
import '../../widgets/bottom_navbar_actions.dart';

class EventFormPage extends StatefulWidget {
  const EventFormPage({Key? key}) : super(key: key);

  @override
  State<EventFormPage> createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  final _formKey = GlobalKey<FormState>();
  XFile? _photo;
  final _eventNameController = TextEditingController();
  final _eventPurposeController = TextEditingController();
  final _eventAddressController = TextEditingController();
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
            children: [
              PhotoFilePicker(
                onPicked: (file) => _photo = file,
                title: 'Foto Sampul',
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Nama Acara',
                placeholder: 'Nama Acara',
                inputType: TextInputType.name,
                controller: _eventNameController,
              ),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: 'Tujuan Acara',
                placeholder: 'Tujuan Acara',
                controller: _eventPurposeController,
                maxlines: 3,
              ),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: 'Alamat Acara',
                placeholder: 'Alamat Acara',
                controller: _eventAddressController,
                maxlines: 3,
              ),
              mediumVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}
