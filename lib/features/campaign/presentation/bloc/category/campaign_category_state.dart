part of 'campaign_category_bloc.dart';

abstract class CampaignCategoryState extends Equatable {
  const CampaignCategoryState();

  @override
  List<Object> get props => [];
}

class CampaignCategoryInitial extends CampaignCategoryState {}

class CampaignCategoryLoading extends CampaignCategoryState {}

class CampaignCategoryLoaded extends CampaignCategoryState {
  final List<CampaignCategory> data;

  const CampaignCategoryLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class CampaignCategoryFailure extends CampaignCategoryState {
  final Failure failure;

  const CampaignCategoryFailure({required this.failure});
  @override
  List<Object> get props => [failure];
}
