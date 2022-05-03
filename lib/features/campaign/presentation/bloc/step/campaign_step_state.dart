part of 'campaign_step_bloc.dart';

class CampaignStepState extends Equatable {
  final List<CampaignStep> steps;
  final CampaignStep currentStep;

  const CampaignStepState({required this.steps, required this.currentStep});

  @override
  List<Object?> get props => [steps, currentStep];
}
