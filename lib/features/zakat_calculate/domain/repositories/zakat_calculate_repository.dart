import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class ZakatCalculateRepository {
  Future<Either<Failure, int>> calculate(int monthlyIncome, int monthlyOtherIncome);
}
