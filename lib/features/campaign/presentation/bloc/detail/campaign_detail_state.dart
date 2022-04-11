part of 'campaign_detail_bloc.dart';

abstract class CampaignDetailState extends Equatable {
  const CampaignDetailState();

  @override
  List<Object> get props => [];
}

class CampaignDetailInitial extends CampaignDetailState {}

class CampaignDetailLoading extends CampaignDetailState {}

class CampaignDetailLoaded extends CampaignDetailState {
  final Campaign data;

  const CampaignDetailLoaded({required this.data});
  @override
  List<Object> get props => [data];
}
