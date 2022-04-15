import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/static/enums.dart';

part 'donate_payment_method_state.dart';

class DonatePaymentMethodCubit extends Cubit<DonatePaymentMethodState> {
  DonatePaymentMethodCubit() : super(DonatePaymentMethodEmpty());

  void select({
    required PaymentMethod method,
    required PaymentChannel channel,
  }) =>
      emit(
        DonatePaymentMethodSelected(
          method: method,
          channel: channel,
        ),
      );
  bool isSelected(PaymentChannel channel) {
    if (state is DonatePaymentMethodSelected) {
      return channel == (state as DonatePaymentMethodSelected).channel;
    }
    return false;
  }
}
