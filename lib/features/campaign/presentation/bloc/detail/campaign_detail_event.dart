part of 'campaign_detail_bloc.dart';

abstract class CampaignDetailEvent extends Equatable {
  const CampaignDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetail extends CampaignDetailEvent {
  final num id;
  final CampaignService service;

  const GetDetail(this.id, this.service);

  @override
  List<Object> get props => [id, service];
}
