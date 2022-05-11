part of 'wallet_topup_bloc.dart';

abstract class WalletTopupState extends Equatable {
  const WalletTopupState();
  
  @override
  List<Object> get props => [];
}

class WalletTopupInitial extends WalletTopupState {}
