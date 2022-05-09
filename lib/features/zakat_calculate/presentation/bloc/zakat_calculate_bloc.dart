import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/calculate.dart' as uc;

part 'zakat_calculate_event.dart';
part 'zakat_calculate_state.dart';

class ZakatCalculateBloc extends Bloc<ZakatCalculateEvent, ZakatCalculateState> {
  final uc.Calculate calculate;
  ZakatCalculateBloc({required this.calculate}) : super(ZakatCalculateInitial()) {
    on<Calculate>((event, emit) async {
      emit(ZakatCalculateLoading());

      final result = await calculate(
        parseToInteger(event.monthlyIncome),
        parseToInteger(event.monthlyOtherIncome),
      );
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
