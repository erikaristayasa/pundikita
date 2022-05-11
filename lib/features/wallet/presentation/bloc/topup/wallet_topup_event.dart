part of 'wallet_topup_bloc.dart';

abstract class WalletTopupEvent extends Equatable {
  const WalletTopupEvent();

  @override
  List<Object> get props => [];
}

class DoTopUp extends WalletTopupEvent {
  final String amount;
  final PaymentMethod paymentMethod;
  final PaymentChannel paymentChannel;

  const DoTopUp({
    required this.amount,
    required this.paymentMethod,
    required this.paymentChannel,
  });

  @override
  List<Object> get props => [
        amount,
        paymentChannel,
        paymentMethod,
      ];
}
