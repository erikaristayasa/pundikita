import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wallet_topup_event.dart';
part 'wallet_topup_state.dart';

class WalletTopupBloc extends Bloc<WalletTopupEvent, WalletTopupState> {
  WalletTopupBloc() : super(WalletTopupInitial()) {
    on<WalletTopupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
