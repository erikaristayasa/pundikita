import 'package:dartz/dartz.dart';
import 'package:pundi_kita/core/errors/failure.dart';
import 'package:pundi_kita/core/static/enums.dart';
import 'package:pundi_kita/features/wallet/domain/entities/topup_result_entity.dart';

abstract class WalletRepository {
  Future<Either<Failure, List<TopUpResult>>> getTopUpHistories();
  Future<Either<Failure, TopUpResult>> topUp({
    required String amount,
    required PaymentMethod paymentMethod,
    required PaymentChannel paymentChannel,
  });
}
