part of 'campaign_category_bloc.dart';

abstract class CampaignCategoryEvent extends Equatable {
  const CampaignCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetData extends CampaignCategoryEvent {}
