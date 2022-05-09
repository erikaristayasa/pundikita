import 'package:dartz/dartz.dart';
import 'package:pundi_kita/features/zakat_calculate/domain/repositories/zakat_calculate_repository.dart';

import '../../../../core/errors/failure.dart';

abstract class ZakatCalculateUseCase<Type> {
  Future<Either<Failure, int>> call(int monthlyIncome, int monthlyOtherIncome);
}

class Calculate implements ZakatCalculateUseCase<int> {
  final ZakatCalculateRepository repository;

  Calculate(this.repository);

  @override
  Future<Either<Failure, int>> call(int monthlyIncome, int monthlyOtherIncome) async {
    return await repository.calculate(monthlyIncome, monthlyOtherIncome);
  }
}
