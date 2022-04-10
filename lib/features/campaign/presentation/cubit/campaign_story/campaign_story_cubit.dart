import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'campaign_story_state.dart';

class CampaignStoryCubit extends Cubit<CampaignStoryState> {
  CampaignStoryCubit() : super(CampaignStoryShrinked());

  void expand() => emit(CampaignStoryExpanded());
  void shrink() => emit(CampaignStoryShrinked());
}
