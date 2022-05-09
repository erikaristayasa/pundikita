part of 'zakat_calculate_bloc.dart';

abstract class ZakatCalculateEvent extends Equatable {
  const ZakatCalculateEvent();

  @override
  List<Object> get props => [];
}

class Calculate extends ZakatCalculateEvent {
  final String monthlyIncome, monthlyOtherIncome;

  const Calculate({
    required this.monthlyIncome,
    required this.monthlyOtherIncome,
  });
  @override
  List<Object> get props => [monthlyIncome, monthlyOtherIncome];
}
