part of 'campaign_sub_category_bloc.dart';

abstract class CampaignSubCategoryEvent extends Equatable {
  const CampaignSubCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetData extends CampaignSubCategoryEvent {
  final int id;

  const GetData({required this.id});

  @override
  List<Object> get props => [id];
}
