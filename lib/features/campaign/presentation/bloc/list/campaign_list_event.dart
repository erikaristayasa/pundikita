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

// class Filtering extends CampaignListEvent {
//   final int categoryId;

//   const Filtering({required this.categoryId});

//   @override
//   List<Object> get props => [categoryId];
// }

// class Sorting extends CampaignListEvent {
//   final SortType type;

//   const Sorting({required this.type});
//   @override
//   List<Object> get props => [type];
// }
