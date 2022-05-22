import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/zakat_calculate_repository.dart';

abstract class ZakatCalculateUseCase<Type> {
  Future<Either<Failure, num>> call({
    required int giroSavingsDepositValue,
    required int vehiclePropertyValue,
    required int goldSilverGgemsOrOthers,
    required int sharesReceivablesAndOtherSecurities,
    required int personalDebtDueThisYear,
  });
}

class CalculatingMaal implements ZakatCalculateUseCase<int> {
  final ZakatCalculateRepository repository;

  CalculatingMaal(this.repository);

  @override
  Future<Either<Failure, num>> call(
      {required int giroSavingsDepositValue,
      required int vehiclePropertyValue,
      required int goldSilverGgemsOrOthers,
      required int sharesReceivablesAndOtherSecurities,
      required int personalDebtDueThisYear}) async {
    return await repository.calculateMaal(
      giroSavingsDepositValue: giroSavingsDepositValue,
      vehiclePropertyValue: vehiclePropertyValue,
      goldSilverGgemsOrOthers: goldSilverGgemsOrOthers,
      sharesReceivablesAndOtherSecurities: sharesReceivablesAndOtherSecurities,
      personalDebtDueThisYear: personalDebtDueThisYear,
    );
  }
}
