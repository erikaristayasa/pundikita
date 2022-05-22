part of 'zakat_calculate_bloc.dart';

abstract class ZakatCalculateEvent extends Equatable {
  const ZakatCalculateEvent();

  @override
  List<Object> get props => [];
}

class Calculate extends ZakatCalculateEvent {
  final String monthlyIncome, monthlyOtherIncome, monthlyInstallmentDebt;

  const Calculate({
    required this.monthlyIncome,
    required this.monthlyOtherIncome,
    required this.monthlyInstallmentDebt,
  });
  @override
  List<Object> get props => [
        monthlyIncome,
        monthlyOtherIncome,
        monthlyInstallmentDebt,
      ];
}

class CalculatingMaal extends ZakatCalculateEvent {
  final String giroSavingsDepositValue, vehiclePropertyValue, goldSilverGgemsOrOthers, sharesReceivablesAndOtherSecurities, personalDebtDueThisYear;

  const CalculatingMaal({
    required this.giroSavingsDepositValue,
    required this.vehiclePropertyValue,
    required this.goldSilverGgemsOrOthers,
    required this.sharesReceivablesAndOtherSecurities,
    required this.personalDebtDueThisYear,
  });

  @override
  List<Object> get props => [
        giroSavingsDepositValue,
        vehiclePropertyValue,
        goldSilverGgemsOrOthers,
        sharesReceivablesAndOtherSecurities,
        personalDebtDueThisYear,
      ];
}
