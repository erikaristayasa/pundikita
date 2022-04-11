part of 'campaign_list_bloc.dart';

abstract class CampaignListEvent extends Equatable {
  const CampaignListEvent();

  @override
  List<Object> get props => [];
}

class GetCampaignList extends CampaignListEvent {
  final CampaignService service;
  final bool auth;

  const GetCampaignList(this.service, {this.auth = false});

  @override
  List<Object> get props => [service, auth];
}

class Filtering extends CampaignListEvent {
  final int categoryId;

  const Filtering({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class Sorting extends CampaignListEvent {
  final SortType type;

  const Sorting({required this.type});
  @override
  List<Object> get props => [type];
}
