part of 'campaign_list_bloc.dart';

abstract class CampaignListState extends Equatable {
  const CampaignListState();

  @override
  List<Object> get props => [];
}

class CampaignListInitial extends CampaignListState {}

class CampaignListLoading extends CampaignListState {}

class CampaignListLoaded extends CampaignListState {
  final List<Campaign> data;

  const CampaignListLoaded({required this.data});
  @override
  List<Object> get props => [data];
}

class CampaignListFailure extends CampaignListState {
  final Failure failure;

  const CampaignListFailure(this.failure);
  @override
  List<Object> get props => [failure];
}
