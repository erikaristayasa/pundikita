import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/static/enums.dart';

import '../../../../../core/domain/entities/campaign_entity.dart';
import '../../../../../core/domain/usecases/get_campaign_detail.dart';
import '../../../../../core/errors/failure.dart';

part 'campaign_detail_event.dart';
part 'campaign_detail_state.dart';

class CampaignDetailBloc extends Bloc<CampaignDetailEvent, CampaignDetailState> {
  final GetCampaignDetail getCampaignDetail;
  CampaignDetailBloc({required this.getCampaignDetail}) : super(CampaignDetailInitial()) {
    on<GetDetail>((event, emit) async {
      emit(CampaignDetailLoading());

      await Future.delayed(const Duration(milliseconds: 1200), () async {
        final result = await getCampaignDetail(event.id.toInt(), service: event.service);
        result.fold(
          (failure) => emit(CampaignDetailFailure(failure)),
          (data) => emit(CampaignDetailLoaded(data: data)),
        );
      });
    });
  }
}
