import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/static/dimens.dart';

import '../../../../core/static/colors.dart';
import '../../../../core/static/extensions.dart';
import '../bloc/step/campaign_step_bloc.dart';

class CampaignCreateStep extends StatelessWidget {
  const CampaignCreateStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignStepBloc, CampaignStepState>(
      builder: (context, state) {
        final _steps = state.steps;
        final _currentStep = state.currentStep;
        return Container(
          height: 40,
          color: AppColors.BG_Grey,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: Dimension.SMALL),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final _step = _steps.elementAt(index);

              return TextButton(
                onPressed: () => context.read<CampaignStepBloc>().add(ChangeStep(step: _step)),
                child: Text(
                  _step.getString(),
                  style: context.textTheme().labelSmall?.apply(color: _step == _currentStep ? AppColors.PRIMARY : Colors.grey),
                ),
              );
            },
            separatorBuilder: (_, __) => const Icon(Icons.arrow_right_alt_rounded),
            itemCount: _steps.length,
          ),
        );
      },
    );
  }
}
