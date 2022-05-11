import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/static/enums.dart';
import '../../domain/entities/topup_result_entity.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_data_source.dart';

class WalletRepositoryImplementation implements WalletRepository {
  final NetworkInfo networkInfo;
  final WalletDataSource dataSource;

  WalletRepositoryImplementation({
    required this.networkInfo,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<TopUpResult>>> getTopUpHistories() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getTopUpHistories();
        result.removeWhere((e) => e.paymentMethod == PaymentMethod.saldo);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }

  @override
  Future<Either<Failure, TopUpResult>> topUp({required String amount, required PaymentMethod paymentMethod, required PaymentChannel paymentChannel}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.topUp(amount: amount, paymentMethod: paymentMethod, paymentChannel: paymentChannel);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }
}
