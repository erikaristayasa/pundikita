part of 'wallet_topup_history_bloc.dart';

abstract class WalletTopupHistoryEvent extends Equatable {
  const WalletTopupHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends WalletTopupHistoryEvent {}
