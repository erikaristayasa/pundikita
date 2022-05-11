import 'package:dartz/dartz.dart';

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
