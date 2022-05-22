import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class ZakatCalculateRepository {
  Future<Either<Failure, num>> calculate(int monthlyIncome, int monthlyOtherIncome, int monthlyInstallmentDebt);
  Future<Either<Failure, num>> calculateMaal({
    required int giroSavingsDepositValue,
    required int vehiclePropertyValue,
    required int goldSilverGgemsOrOthers,
    required int sharesReceivablesAndOtherSecurities,
    required int personalDebtDueThisYear,
  });
}
