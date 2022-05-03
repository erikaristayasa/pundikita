import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/enums.dart' as e;
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
            children: const [
              CampaignCreateStep(),
              Expanded(child: ColoredBox(color: AppColors.PRIMARY)),
            ],
          ),
        ),
      ),
    );
  }
}
