part of 'wallet_topup_bloc.dart';

abstract class WalletTopupState extends Equatable {
  const WalletTopupState();

  @override
  List<Object> get props => [];
}

class WalletTopupInitial extends WalletTopupState {}

class WalletTopupLoading extends WalletTopupState {}

class WalletTopupSuccess extends WalletTopupState {
  final TopUpResult result;

  const WalletTopupSuccess({required this.result});
  @override
  List<Object> get props => [result];
}

class WalletTopupFailed extends WalletTopupState {
  final Failure failure;

  const WalletTopupFailed({required this.failure});
  @override
  List<Object> get props => [failure];
}
