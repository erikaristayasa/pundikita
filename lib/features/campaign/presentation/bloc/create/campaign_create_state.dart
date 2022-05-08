part of 'campaign_create_bloc.dart';

abstract class CampaignCreateState extends Equatable {
  const CampaignCreateState();

  @override
  List<Object> get props => [];
}

class CampaignCreateInitial extends CampaignCreateState {}

class CampaignCreatePrepare extends CampaignCreateState {
  final Map<String, dynamic> body;

  const CampaignCreatePrepare({required this.body});
  @override
  List<Object> get props => [body];
}

class CampaignCreateLoading extends CampaignCreateState {}

class CampaignCreateSuccess extends CampaignCreateState {}

class CampaignCreateFailure extends CampaignCreateState {
  final Failure failure;

  const CampaignCreateFailure({required this.failure});
  @override
  List<Object> get props => [failure];
}
