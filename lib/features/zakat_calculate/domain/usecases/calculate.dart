import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/zakat_calculate_repository.dart';

abstract class ZakatCalculateUseCase<Type> {
  Future<Either<Failure, num>> call(int monthlyIncome, int monthlyOtherIncome, int monthlyInstallmentDebt);
}

class Calculate implements ZakatCalculateUseCase<int> {
  final ZakatCalculateRepository repository;

  Calculate(this.repository);

  @override
  Future<Either<Failure, num>> call(int monthlyIncome, int monthlyOtherIncome, int monthlyInstallmentDebt) async {
    return await repository.calculate(monthlyIncome, monthlyOtherIncome, monthlyInstallmentDebt);
  }
}
