import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/static/enums.dart';

part 'campaign_step_event.dart';
part 'campaign_step_state.dart';

class CampaignStepBloc extends Bloc<CampaignStepEvent, CampaignStepState> {
  CampaignStepBloc()
      : super(
          const CampaignStepState(
            steps: [],
            currentStep: CampaignStep.prepare,
          ),
        ) {
    on<InitialSteps>((event, emit) {
      late List<CampaignStep> _steps;
      switch (event.type) {
        case CampaignType.sick:
          _steps = [
            CampaignStep.prepare,
            CampaignStep.patient,
            CampaignStep.fundTarget,
            CampaignStep.recipient,
            CampaignStep.advertisement,
          ];
          break;
        case CampaignType.other:
          _steps = [
            CampaignStep.prepare,
            CampaignStep.personalData,
            CampaignStep.fundTarget,
            CampaignStep.recipient,
            CampaignStep.event,
          ];
          break;
      }
      emit(CampaignStepState(steps: _steps, currentStep: state.currentStep));
    });
    on<ChangeStep>((event, emit) {
      emit(CampaignStepState(steps: state.steps, currentStep: event.step));
    });
  }
}
