import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/widgets/custom_text_area.dart';
import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/static/dimens.dart';
import '../../../../../core/utility/helper.dart';
import '../../bloc/create/campaign_create_bloc.dart';
import '../../bloc/step/campaign_step_bloc.dart';
import '../../widgets/bottom_navbar_actions.dart';

class EventFormPage extends StatefulWidget {
  const EventFormPage({Key? key}) : super(key: key);

  @override
  State<EventFormPage> createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _eventPurposeController = TextEditingController();
  final _eventAddressController = TextEditingController();

  Future<Map<String, dynamic>> mapValue() async => {
        'nama_acara': _eventNameController.text,
        'tujuan_acara': _eventPurposeController.text,
        'lokasi_acara': _eventAddressController.text,
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
            children: [
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
