import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/static/enums.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodEmpty());

  void select({
    required PaymentMethod method,
    required PaymentChannel channel,
  }) =>
      emit(
        PaymentMethodSelected(
          method: method,
          channel: channel,
        ),
      );
  bool isSelected(PaymentChannel channel) {
    if (state is PaymentMethodSelected) {
      return channel == (state as PaymentMethodSelected).channel;
    }
    return false;
  }
}
