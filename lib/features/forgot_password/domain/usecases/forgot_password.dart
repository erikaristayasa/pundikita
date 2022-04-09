import 'package:dartz/dartz.dart';
import 'package:pundi_kita/features/forgot_password/domain/repositories/forgot_password_repository.dart';

abstract class ForgotPasswordUseCase<Type> {
  Future<Either<String, String>> call(String email);
}

class ForgotPassword implements ForgotPasswordUseCase<String> {
  final ForgotPasswordRepository repository;

  ForgotPassword(this.repository);

  @override
  Future<Either<String, String>> call(String email) async {
    return await repository.forgotPassword(email);
  }
}
