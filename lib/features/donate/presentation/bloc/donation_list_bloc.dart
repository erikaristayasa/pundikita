import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/donation_entity.dart';
import '../../../../core/domain/usecases/get_donation_list.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/static/enums.dart';

part 'donation_list_event.dart';
part 'donation_list_state.dart';

class DonationListBloc extends Bloc<DonationListEvent, DonationListState> {
  final GetDonationList getDonationList;
  DonationListBloc({required this.getDonationList}) : super(DonationListInitial()) {
    on<GetData>((event, emit) async {
      emit(DonationListLoading());

      await Future.delayed(const Duration(milliseconds: 800), () async {
        final result = await getDonationList(service: event.service);
        result.fold(
          (failure) => emit(DonationListFailure(failure: failure)),
          (data) => emit(DonationListLoaded(data: data)),
        );
      });
    });
  }
}
