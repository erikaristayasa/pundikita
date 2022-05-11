import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/topup_result_entity.dart';
import '../../../domain/usecases/get_topup_histories.dart';

part 'wallet_topup_history_event.dart';
part 'wallet_topup_history_state.dart';

class WalletTopupHistoryBloc extends Bloc<WalletTopupHistoryEvent, WalletTopupHistoryState> {
  final GetTopUpHistories getTopUpHistories;
  WalletTopupHistoryBloc({required this.getTopUpHistories}) : super(WalletTopupHistoryInitial()) {
    on<FetchData>((event, emit) async {
      emit(WalletTopupHistoryLoading());

      final result = await getTopUpHistories();
      result.fold(
        (failure) => emit(WalletTopupHistoryFailure(failure: failure)),
        (data) => emit(WalletTopupHistoryLoaded(data: data)),
      );
    });
  }
}
