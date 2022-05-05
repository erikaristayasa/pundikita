import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/presentation/pages/loading_page.dart';
import 'package:pundi_kita/features/campaign/presentation/pages/forms/patient_form_page.dart';
import 'package:pundi_kita/features/campaign/presentation/pages/forms/prepare_form_page.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/enums.dart' as e;
import '../../../../core/static/enums.dart';
import '../bloc/step/campaign_step_bloc.dart';
import '../widgets/campaign_create_step.dart';

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
                        // TODO: Handle this case.
                        break;
                      case CampaignStep.fundTarget:
                        // TODO: Handle this case.
                        break;
                      case CampaignStep.recipient:
                        // TODO: Handle this case.
                        break;
                      case CampaignStep.advertisement:
                        // TODO: Handle this case.
                        break;
                      case CampaignStep.event:
                        // TODO: Handle this case.
                        break;
                    }
                    return const LoadingPage(isList: true);
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
