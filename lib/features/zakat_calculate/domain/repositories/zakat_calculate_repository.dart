import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class ZakatCalculateRepository {
  Future<Either<Failure, num>> calculate(int monthlyIncome, int monthlyOtherIncome, int monthlyInstallmentDebt);
}
