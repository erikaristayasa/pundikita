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
            CampaignStep.personalData,
            CampaignStep.fundTarget,
            CampaignStep.recipient,
            CampaignStep.event,
            CampaignStep.advertisement,
          ];
          break;
      }
      emit(CampaignStepState(steps: _steps, currentStep: _steps.first));
    });
    on<ChangeStep>((event, emit) {
      emit(CampaignStepState(steps: state.steps, currentStep: event.step));
    });
    on<ToNextStep>((event, emit) {
      final _steps = state.steps;
      final _currentIndex = _steps.indexOf(state.currentStep);
      final _nextStep = _steps.elementAt(_currentIndex + 1);
      emit(CampaignStepState(steps: _steps, currentStep: _nextStep));
    });
    on<ToPreviousStep>((event, emit) {
      final _steps = state.steps;
      final _currentIndex = _steps.indexOf(state.currentStep);
      final _previousStep = _steps.elementAt(_currentIndex - 1);
      emit(CampaignStepState(steps: _steps, currentStep: _previousStep));
    });
  }
}
