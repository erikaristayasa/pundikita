part of 'campaign_step_bloc.dart';

abstract class CampaignStepEvent extends Equatable {
  const CampaignStepEvent();

  @override
  List<Object> get props => [];
}

class InitialSteps extends CampaignStepEvent {
  final CampaignType type;

  const InitialSteps({required this.type});

  @override
  List<Object> get props => [type];
}

class ChangeStep extends CampaignStepEvent {
  final CampaignStep step;

  const ChangeStep({required this.step});
  @override
  List<Object> get props => [step];
}

class ToNextStep extends CampaignStepEvent {}
