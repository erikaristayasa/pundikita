import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/features/campaign/presentation/pages/forms/event_form_page.dart';

import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/enums.dart' as e;
import '../../../../core/static/enums.dart';
import '../bloc/step/campaign_step_bloc.dart';
import '../widgets/campaign_create_step.dart';
import 'forms/advertisement_form_page.dart';
import 'forms/fund_target_form_page.dart';
import 'forms/patient_form_page.dart';
import 'forms/personal_data_form_page.dart';
import 'forms/prepare_form_page.dart';
import 'forms/recipient_form_page.dart';

class CampaignCreatePageRouteArguments {
  final e.CampaignType type;
  CampaignCreatePageRouteArguments({required this.type});
}

class CampaignCreatePage extends StatelessWidget {
  final e.CampaignType type;
  const CampaignCreatePage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CampaignStepBloc()..add(InitialSteps(type: type)),
        ),
      ],
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Buat Galang Dana",
          canBack: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const CampaignCreateStep(),
              Expanded(
                child: BlocBuilder<CampaignStepBloc, CampaignStepState>(
                  builder: (context, state) {
                    final _step = state.currentStep;
                    switch (_step) {
                      case CampaignStep.prepare:
                        return const PrepareFormPage();
                      case CampaignStep.patient:
                        return const PatientFormPage();
                      case CampaignStep.personalData:
                        return const PersonalDataFormPage();
                      case CampaignStep.fundTarget:
                        return const FundTargetFormPage();
                      case CampaignStep.recipient:
                        return const RecipientFormPage();
                      case CampaignStep.advertisement:
                        return const AdvertisementFormPage();
                      case CampaignStep.event:
                        return const EventFormPage();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
