import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/static/enums.dart';
import '../../../domain/entities/topup_result_entity.dart';
import '../../../domain/usecases/topup.dart';

part 'wallet_topup_event.dart';
part 'wallet_topup_state.dart';

class WalletTopupBloc extends Bloc<WalletTopupEvent, WalletTopupState> {
  final TopUp topUp;
  WalletTopupBloc({required this.topUp}) : super(WalletTopupInitial()) {
    on<DoTopUp>((event, emit) async {
      emit(WalletTopupLoading());

      final result = await topUp(
        amount: event.amount,
        paymentMethod: event.paymentMethod,
        paymentChannel: event.paymentChannel,
      );

      result.fold(
        (failure) => emit(WalletTopupFailed(failure: failure)),
        (result) => emit(WalletTopupSuccess(result: result)),
      );
    });
  }
}
