import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/presentation/widgets/custom_text_area.dart';
import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/presentation/widgets/photo_file_picker.dart';
import '../../../../../core/static/dimens.dart';
import '../../../../../core/utility/helper.dart';
import '../../bloc/create/campaign_create_bloc.dart';
import '../../bloc/step/campaign_step_bloc.dart';
import '../../widgets/bottom_navbar_actions.dart';

class AdvertisementFormPage extends StatefulWidget {
  const AdvertisementFormPage({Key? key}) : super(key: key);

  @override
  State<AdvertisementFormPage> createState() => _AdvertisementFormPageState();
}

class _AdvertisementFormPageState extends State<AdvertisementFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _storyController = TextEditingController();
  final _invitationSpeechController = TextEditingController();
  XFile? _photo;

  Future<Map<String, dynamic>> mapValue() async => {
        if (_photo != null) 'foto': await MultipartFile.fromFile(_photo!.path, filename: _photo!.name),
        'judul': _titleController.text,
        'cerita': _storyController.text,
        'ajakan_singkat': _invitationSpeechController.text,
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
            // context.read<CampaignStepBloc>().add(ToNextStep());
            context.read<CampaignCreateBloc>().add(UpdateBody(body: await mapValue()));
            context.read<CampaignCreateBloc>().add(Submit());
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
              PhotoFilePicker(
                onPicked: (file) => _photo = file,
                title: 'Foto Sampul',
                validation: true,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: 'Judul Donasi',
                placeholder: 'Judul Donasi',
                inputType: TextInputType.name,
                controller: _titleController,
              ),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: 'Cerita',
                placeholder: 'Cerita',
                controller: _storyController,
                maxlines: 5,
              ),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: 'Ajakan Singkat',
                placeholder: 'Ajakan Singkat',
                controller: _invitationSpeechController,
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
