import 'package:dartz/dartz.dart';

abstract class ForgotPasswordRepository {
  Future<Either<String, String>> forgotPassword(String email);
}
