import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/widgets/custom_enddate_input.dart';
import '../../../../../core/presentation/widgets/custom_text_area.dart';
import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../../core/static/colors.dart';
import '../../../../../core/static/dimens.dart';
import '../../../../../core/static/extensions.dart';
import '../../../../../core/utility/helper.dart';
import '../../../../../core/utility/validation_helper.dart';
import '../../bloc/create/campaign_create_bloc.dart';
import '../../bloc/step/campaign_step_bloc.dart';
import '../../widgets/bottom_navbar_actions.dart';

class FundTargetFormPage extends StatefulWidget {
  const FundTargetFormPage({Key? key}) : super(key: key);

  @override
  State<FundTargetFormPage> createState() => _FundTargetFormPageState();
}

class _FundTargetFormPageState extends State<FundTargetFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fundAmountController = TextEditingController();
  final _endDateController = TextEditingController();
  final _fundUsageDetailController = TextEditingController();
  Map<String, dynamic> mapValue() => {
        'jumlah_dana': int.parse((_fundAmountController.text).replaceAll('.', '')),
        'tanggal_selesai': _endDateController.text,
        'rincian_penggunaan_dana': _fundUsageDetailController.text,
      };

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
            context.read<CampaignCreateBloc>().add(UpdateBody(body: mapValue()));
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
                  'Tentukan target donasi anda.',
                  style: context.textTheme().bodySmall,
                ),
              ),
              largeVerticalSpacing(),
              CustomTextField(
                title: 'Jumlah Dana',
                placeholder: 'Jumlah Dana',
                prefixText: 'Rp',
                inputType: TextInputType.number,
                typeField: TypeField.none,
                controller: _fundAmountController,
                formatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyTextInputFormatter(
                    locale: 'id',
                    decimalDigits: 0,
                    symbol: '',
                  )
                ],
              ),
              mediumVerticalSpacing(),
              CustomEndDateInput(
                title: 'Tanggal Selesai',
                date: _endDateController.text.toDate(),
                controller: _endDateController,
              ),
              mediumVerticalSpacing(),
              CustomTextArea(
                title: 'Rincian Penggunaan Dana',
                controller: _fundUsageDetailController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
