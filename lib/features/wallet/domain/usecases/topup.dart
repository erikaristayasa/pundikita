import 'package:dartz/dartz.dart';
import 'package:pundi_kita/features/wallet/domain/repositories/wallet_repository.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/static/enums.dart';
import '../entities/topup_result_entity.dart';

abstract class ToUpWalletUseCase<Type> {
  Future<Either<Failure, TopUpResult>> call({
    required String amount,
    required PaymentMethod paymentMethod,
    required PaymentChannel paymentChannel,
  });
}

class TopUp implements ToUpWalletUseCase<TopUpResult> {
  final WalletRepository repository;

  TopUp(this.repository);

  @override
  Future<Either<Failure, TopUpResult>> call({required String amount, required PaymentMethod paymentMethod, required PaymentChannel paymentChannel}) async {
    return await repository.topUp(amount: amount, paymentMethod: paymentMethod, paymentChannel: paymentChannel);
  }
}
