import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/donation_entity.dart';
import '../../../domain/usecases/get_all_donation.dart';
import '../../../errors/failure.dart';

part 'all_donation_event.dart';
part 'all_donation_state.dart';

class AllDonationBloc extends Bloc<AllDonationEvent, AllDonationState> {
  final GetAllDonation getAllDonation;
  AllDonationBloc({required this.getAllDonation}) : super(AllDonationInitial()) {
    on<FetchData>((event, emit) async {
      emit(AllDonationLoading());

      final result = await getAllDonation();
      result.fold(
        (failure) => emit(AllDonationFailure(failure: failure)),
        (data) => emit(AllDonationLoaded(data: data)),
      );
    });
  }
}
