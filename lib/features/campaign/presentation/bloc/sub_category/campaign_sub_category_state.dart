part of 'campaign_sub_category_bloc.dart';

abstract class CampaignSubCategoryState extends Equatable {
  const CampaignSubCategoryState();

  @override
  List<Object> get props => [];
}

class CampaignSubCategoryInitial extends CampaignSubCategoryState {}

class CampaignSubCategoryLoading extends CampaignSubCategoryState {}

class CampaignSubCategoryLoaded extends CampaignSubCategoryState {
  final List<CampaignSubCategory> data;

  const CampaignSubCategoryLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class CampaignSubCategoryFailure extends CampaignSubCategoryState {
  final Failure failure;

  const CampaignSubCategoryFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
