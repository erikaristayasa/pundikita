part of 'campaign_type_bloc.dart';

abstract class CampaignTypeState extends Equatable {
  const CampaignTypeState();

  @override
  List<Object> get props => [];
}

class CampaignTypeInitial extends CampaignTypeState {}

class CampaignTypeLoading extends CampaignTypeState {}

class CampaignTypeLoaded extends CampaignTypeState {
  final List<CampaignType> data;

  const CampaignTypeLoaded({required this.data});
  @override
  List<Object> get props => [data];
}

class CampaignTypeFailure extends CampaignTypeState {
  final Failure failure;

  const CampaignTypeFailure({required this.failure});
  @override
  List<Object> get props => [failure];
}
