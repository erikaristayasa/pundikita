part of 'payment_method_cubit.dart';

abstract class PaymentMethodState extends Equatable {
  const PaymentMethodState();

  @override
  List<Object> get props => [];
}

class PaymentMethodEmpty extends PaymentMethodState {}

class PaymentMethodSelected extends PaymentMethodState {
  final PaymentMethod method;
  final PaymentChannel channel;

  const PaymentMethodSelected({required this.method, required this.channel});

  @override
  List<Object> get props => [method, channel];
}
