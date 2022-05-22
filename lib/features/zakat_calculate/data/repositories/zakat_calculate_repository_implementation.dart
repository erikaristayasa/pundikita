import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/zakat_calculate_repository.dart';
import '../datasources/zakat_calculate_data_source.dart';

class ZakatCalculateRepositoryImplementation implements ZakatCalculateRepository {
  final NetworkInfo networkInfo;
  final ZakatCalculateDataSource dataSource;

  ZakatCalculateRepositoryImplementation({
    required this.networkInfo,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, num>> calculate(int monthlyIncome, int monthlyOtherIncome, int monthlyInstallmentDebt) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.calculate(monthlyIncome, monthlyOtherIncome, monthlyInstallmentDebt);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }
}
