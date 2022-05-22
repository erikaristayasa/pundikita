import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/calculate.dart' as uc;
import '../../domain/usecases/calculating_maal.dart' as uc2;

part 'zakat_calculate_event.dart';
part 'zakat_calculate_state.dart';

class ZakatCalculateBloc extends Bloc<ZakatCalculateEvent, ZakatCalculateState> {
  final uc.Calculate calculate;
  final uc2.CalculatingMaal calculatingMaal;
  ZakatCalculateBloc({required this.calculate, required this.calculatingMaal}) : super(ZakatCalculateInitial()) {
    on<Calculate>((event, emit) async {
      emit(ZakatCalculateLoading());

      final result = await calculate(
        parseToInteger(event.monthlyIncome),
        parseToInteger(event.monthlyOtherIncome),
        parseToInteger(event.monthlyInstallmentDebt),
      );
      result.fold(
        (failure) => emit(ZakatCalculateFailure(failure: failure)),
        (data) => emit(ZakatCalculateSuccess(data: data)),
      );
    });
    on<CalculatingMaal>((event, emit) async {
      emit(ZakatCalculateLoading());
      final result = await calculatingMaal(
          giroSavingsDepositValue: parseToInteger(event.giroSavingsDepositValue),
          vehiclePropertyValue: parseToInteger(event.vehiclePropertyValue),
          goldSilverGgemsOrOthers: parseToInteger(event.goldSilverGgemsOrOthers),
          sharesReceivablesAndOtherSecurities: parseToInteger(event.sharesReceivablesAndOtherSecurities),
          personalDebtDueThisYear: parseToInteger(event.personalDebtDueThisYear));
      result.fold(
        (failure) => emit(ZakatCalculateFailure(failure: failure)),
        (data) => emit(ZakatCalculateSuccess(data: data)),
      );
    });
  }

  int parseToInteger(String value) {
    try {
      final number = int.parse(value.replaceAll('.', ''));
      return number;
    } catch (e) {
      return 0;
    }
  }
}
