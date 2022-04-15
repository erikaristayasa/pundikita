part of 'donate_payment_method_cubit.dart';

abstract class DonatePaymentMethodState extends Equatable {
  const DonatePaymentMethodState();

  @override
  List<Object> get props => [];
}

class DonatePaymentMethodEmpty extends DonatePaymentMethodState {}

class DonatePaymentMethodSelected extends DonatePaymentMethodState {
  final PaymentMethod method;
  final PaymentChannel channel;

  const DonatePaymentMethodSelected({required this.method, required this.channel});

  @override
  List<Object> get props => [method, channel];
}
