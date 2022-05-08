import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../../core/static/colors.dart';
import '../../../../../core/static/dimens.dart';
import '../../../../../core/static/enums.dart';
import '../../../../../core/static/extensions.dart';
import '../../../../../core/utility/helper.dart';
import '../../../../../core/utility/validation_helper.dart';
import '../../bloc/create/campaign_create_bloc.dart';
import '../../bloc/step/campaign_step_bloc.dart';
import '../../widgets/bottom_navbar_actions.dart';

class PrepareFormPage extends StatefulWidget {
  const PrepareFormPage({Key? key}) : super(key: key);

  @override
  State<PrepareFormPage> createState() => _PrepareFormPageState();
}

class _PrepareFormPageState extends State<PrepareFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _patientPhoneController = TextEditingController();
  WhoSick _whoSick = WhoSick.me;

  final _border = inputFieldBorder;

  Map<String, dynamic> mapValue() => {
        'telepon': _phoneController.text,
        if (_patientPhoneController.text.isNotEmpty) 'telepon_pasien': _patientPhoneController.text,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarActions(
        onNext: () {
          if (_formKey.currentState!.validate()) {
            context.read<CampaignStepBloc>().add(ToNextStep());
            context.read<CampaignCreateBloc>().add(UpdateBody(body: mapValue()));
          }
        },
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(Dimension.MEDIUM),
          children: [
            RoundedContainer(
              color: AppColors.SECONDARY.withOpacity(0.15),
              child: Text(
                'Tentukan untuk siapa donasi ditujukan dan kontak yang dapat dihubungi.',
                style: context.textTheme().bodySmall,
              ),
            ),
            largeVerticalSpacing(),
            Text(
              'Siapa yang sakit?',
              style: context.textTheme().titleSmall,
            ),
            DropdownButtonFormField<WhoSick>(
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: InputBorder.none,
                focusedBorder: _border,
                enabledBorder: _border,
                filled: true,
                fillColor: Colors.grey[200],
              ),
              value: _whoSick,
              items: List<DropdownMenuItem<WhoSick>>.from(
                WhoSick.values.map(
                  (e) => DropdownMenuItem<WhoSick>(
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
                  _whoSick = value!;
                });
              },
            ),
            mediumVerticalSpacing(),
            CustomTextField(
              title: 'Nomor Telepon Anda',
              inputType: TextInputType.phone,
              typeField: TypeField.phone,
              controller: _phoneController,
            ),
            mediumVerticalSpacing(),
            _whoSick == WhoSick.others
                ? CustomTextField(
                    title: 'Nomor Telepon Pasien',
                    inputType: TextInputType.phone,
                    typeField: TypeField.phone,
                    controller: _patientPhoneController,
                  )
                : const SizedBox.shrink(),
            mediumVerticalSpacing(),
          ],
        ),
      ),
    );
  }
}
