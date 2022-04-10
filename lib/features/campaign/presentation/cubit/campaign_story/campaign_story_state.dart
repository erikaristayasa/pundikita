part of 'campaign_story_cubit.dart';

abstract class CampaignStoryState extends Equatable {
  const CampaignStoryState();

  @override
  List<Object> get props => [];
}

class CampaignStoryShrinked extends CampaignStoryState {}

class CampaignStoryExpanded extends CampaignStoryState {}
