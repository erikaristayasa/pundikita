import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../../../../core/domain/usecases/create_campaign.dart';
import '../../../../../core/errors/failure.dart';

part 'campaign_create_event.dart';
part 'campaign_create_state.dart';

class CampaignCreateBloc extends Bloc<CampaignCreateEvent, CampaignCreateState> {
  final CreateCampaign createCampaign;
  CampaignCreateBloc({required this.createCampaign}) : super(CampaignCreateInitial()) {
    on<UpdateBody>((event, emit) {
      if (state is CampaignCreateInitial) {
        emit(CampaignCreatePrepare(body: event.body));
      } else if (state is CampaignCreatePrepare) {
        final _updatedBody = updateStateMapBody(event.body);
        emit(CampaignCreatePrepare(body: _updatedBody));
      } else {
        emit(CampaignCreateInitial());
      }
    });
    on<Submit>((event, emit) async {
      if (state is CampaignCreatePrepare) {
        final _body = (state as CampaignCreatePrepare).body;
        logMe(_body);
        emit(CampaignCreateLoading());

        final result = await createCampaign(_body);
        result.fold(
          (failure) async {
            emit(CampaignCreateFailure(failure: failure));
            await Future.delayed(const Duration(milliseconds: 2));
            emit(CampaignCreatePrepare(body: _body));
          },
          (_) => emit(CampaignCreateSuccess()),
        );
      }
    });
  }

  Map<String, dynamic> updateStateMapBody(Map<String, dynamic> newMap) {
    final _temp = (state as CampaignCreatePrepare).body;
    newMap.forEach((key, value) {
      _temp[key] = value;
    });
    return _temp;
  }
}
