import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/domain/entities/donation_entity.dart';
import '../../../../core/domain/usecases/request_inquiry.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/static/enums.dart';

part 'request_inquiry_event.dart';
part 'request_inquiry_state.dart';

class RequestInquiryBloc extends Bloc<RequestInquiryEvent, RequestInquiryState> {
  final RequestInquiry requestInquiry;

  RequestInquiryBloc({required this.requestInquiry}) : super(RequestInquiryInitial()) {
    on<OnSubmit>((event, emit) async {
      emit(RequestInquiryLoading());

      final result = await requestInquiry(getRequestBody(event), service: event.campaign.campaignService);
      result.fold(
        (failure) {
          emit(RequestInquiryFailure(failure: failure));
        },
        (data) {
          emit(RequestInquirySuccess(data: data));
        },
      );
    });
  }

  Map<String, dynamic> getRequestBody(OnSubmit event) {
    return {
      'campaign_id': event.campaign.id,
      'jumlah_dana': event.nominal,
      'doa': event.pray,
      'payment_method': event.method.name,
      'payment_channel': event.channel.name,
    };
  }
}
