import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/presentation/widgets/custom_text_field.dart';
import 'package:pundi_kita/core/presentation/widgets/rounded_button.dart';
import 'package:pundi_kita/core/presentation/widgets/rounded_container.dart';
import 'package:pundi_kita/core/static/colors.dart';
import 'package:pundi_kita/core/static/dimens.dart';
import 'package:pundi_kita/core/static/enums.dart';
import 'package:pundi_kita/core/static/extensions.dart';
import 'package:pundi_kita/core/utility/app_locale.dart';
import 'package:pundi_kita/core/utility/helper.dart';
import 'package:pundi_kita/features/campaign/presentation/bloc/step/campaign_step_bloc.dart';

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

  final _border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Form(
        key: _formKey,
        child: ListView(
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
              controller: _phoneController,
            ),
            mediumVerticalSpacing(),
            _whoSick == WhoSick.others
                ? CustomTextField(
                    title: 'Nomor Telepon Pasien',
                    inputType: TextInputType.phone,
                    controller: _patientPhoneController,
                  )
                : const SizedBox.shrink(),
            mediumVerticalSpacing(),
            RoundedButton(
              title: AppLocale.loc.next,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  context.read<CampaignStepBloc>().add(ToNextStep());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
