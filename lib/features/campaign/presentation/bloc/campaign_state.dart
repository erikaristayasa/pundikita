part of 'campaign_bloc.dart';

abstract class CampaignState extends Equatable {
  const CampaignState();  

  @override
  List<Object> get props => [];
}
class CampaignInitial extends CampaignState {}
