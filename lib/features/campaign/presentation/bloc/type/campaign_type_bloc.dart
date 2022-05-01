import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/entities/campaign_entity.dart';
import '../../../../../core/domain/usecases/get_campaign_types.dart';
import '../../../../../core/errors/failure.dart';

part 'campaign_type_event.dart';
part 'campaign_type_state.dart';

class CampaignTypeBloc extends Bloc<CampaignTypeEvent, CampaignTypeState> {
  final GetCampaignTypes getCampaignTypes;
  CampaignTypeBloc({required this.getCampaignTypes}) : super(CampaignTypeInitial()) {
    on<GetData>((event, emit) async {
      emit(CampaignTypeLoading());

      await Future.delayed(const Duration(milliseconds: 800), () async {
        final result = await getCampaignTypes();
        result.fold(
          (failure) => emit(CampaignTypeFailure(failure: failure)),
          (data) => emit(CampaignTypeLoaded(data: data)),
        );
      });
    });
  }
}
