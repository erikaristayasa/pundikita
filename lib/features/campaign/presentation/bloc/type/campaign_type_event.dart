part of 'campaign_type_bloc.dart';

abstract class CampaignTypeEvent extends Equatable {
  const CampaignTypeEvent();

  @override
  List<Object> get props => [];
}

class GetData extends CampaignTypeEvent {}
