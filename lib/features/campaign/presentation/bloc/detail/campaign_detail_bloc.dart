import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/entities/campaign_entity.dart';
import '../../../../../core/domain/usecases/get_campaign_detail.dart';

part 'campaign_detail_event.dart';
part 'campaign_detail_state.dart';

class CampaignDetailBloc extends Bloc<CampaignDetailEvent, CampaignDetailState> {
  final GetCampaignDetail getCampaignDetail;
  CampaignDetailBloc({required this.getCampaignDetail}) : super(CampaignDetailInitial()) {
    on<CampaignDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
