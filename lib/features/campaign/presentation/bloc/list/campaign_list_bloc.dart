import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/entities/campaign_entity.dart';
import '../../../../../core/domain/usecases/get_all_campaign_list.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/static/enums.dart';

part 'campaign_list_event.dart';
part 'campaign_list_state.dart';

class CampaignListBloc extends Bloc<CampaignListEvent, CampaignListState> {
  final GetAllCampaignList getAllCampaignList;
  CampaignListBloc({
    required this.getAllCampaignList,
  }) : super(CampaignListInitial()) {
    on<GetCampaignList>((event, emit) async {
      emit(CampaignListLoading());

      final _service = event.service;
      final _auth = event.auth;
      final _category = event.category;
      final _sort = event.sort;
      await Future.delayed(const Duration(milliseconds: 1500), () async {
        final result = await getAllCampaignList(_service, auth: _auth, category: _category?.id == 0 ? null : _category, sort: _sort);
        result.fold(
          (failure) => emit(CampaignListFailure(failure)),
          (data) {
            if (data.isEmpty) {
              emit(CampaignListInitial());
            } else {
              emit(CampaignListLoaded(data: data));
            }
          },
        );
      });
    });
  }
}
