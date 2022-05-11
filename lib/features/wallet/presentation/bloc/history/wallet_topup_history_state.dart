part of 'wallet_topup_history_bloc.dart';

abstract class WalletTopupHistoryState extends Equatable {
  const WalletTopupHistoryState();

  @override
  List<Object> get props => [];
}

class WalletTopupHistoryInitial extends WalletTopupHistoryState {}

class WalletTopupHistoryLoading extends WalletTopupHistoryState {}

class WalletTopupHistoryLoaded extends WalletTopupHistoryState {
  final List<TopUpResult> data;

  const WalletTopupHistoryLoaded({required this.data});
  @override
  List<Object> get props => [data];
}

class WalletTopupHistoryFailure extends WalletTopupHistoryState {
  final Failure failure;

  const WalletTopupHistoryFailure({required this.failure});
  @override
  List<Object> get props => [failure];
}
