import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/topup_result_entity.dart';
import '../repositories/wallet_repository.dart';

abstract class TopUpHistoryUseCase<Type> {
  Future<Either<Failure, List<TopUpResult>>> call();
}

class GetTopUpHistories implements TopUpHistoryUseCase<List<TopUpResult>> {
  final WalletRepository repository;

  GetTopUpHistories(this.repository);

  @override
  Future<Either<Failure, List<TopUpResult>>> call() async {
    return await repository.getTopUpHistories();
  }
}
