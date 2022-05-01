part of 'campaign_list_bloc.dart';

abstract class CampaignListEvent extends Equatable {
  const CampaignListEvent();

  @override
  List<Object> get props => [];
}

class GetCampaignList extends CampaignListEvent {
  final CampaignService service;
  final bool auth;
  final CampaignCategory? category;
  final bool? sort;

  const GetCampaignList(
    this.service, {
    this.auth = false,
    this.category,
    this.sort,
  });

  @override
  List<Object> get props => [
        service,
        auth,
        category ?? const CampaignCategory(id: 0, icon: '', categoryName: ''),
        sort ?? false,
      ];
}
