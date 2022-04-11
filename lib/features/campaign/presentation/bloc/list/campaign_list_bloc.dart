import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/entities/campaign_entity.dart';
import '../../../../../core/domain/usecases/get_all_campaign_list.dart';
import '../../../../../core/domain/usecases/get_user_campaign_list.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/static/enums.dart';

part 'campaign_list_event.dart';
part 'campaign_list_state.dart';

class CampaignListBloc extends Bloc<CampaignListEvent, CampaignListState> {
  final GetAllCampaignList getAllCampaignList;
  final GetUserCampaignList getUserCampaignList;
  CampaignListBloc({
    required this.getAllCampaignList,
    required this.getUserCampaignList,
  }) : super(CampaignListInitial()) {
    on<GetCampaignList>((event, emit) async {
      emit(CampaignListLoading());

      final _service = event.service;
      final _auth = event.auth;
      final result = _auth ? await getUserCampaignList(_service) : await getAllCampaignList(_service);
      result.fold(
        (failure) => emit(CampaignListFailure(failure)),
        (data) {
          emit(CampaignListLoaded(data: data));
        },
      );
    });

    on<Filtering>((event, emit) {
      //TODO: Implements filtering
    });

    on<Sorting>((event, emit) {
      //TODO: Implements sorting
    });
  }
}
