import 'package:dartz/dartz.dart';

import '../entities/register_request_body.dart';
import '../repositories/register_repository.dart';

abstract class RegisterUseCase<Type> {
  Future<Either<String, String>> call(RegisterRequestBody body, {required Map<String, dynamic> additionalBody});
}

class Register implements RegisterUseCase<String> {
  final RegisterRepository repository;

  Register(this.repository);

  @override
  Future<Either<String, String>> call(RegisterRequestBody body, {required Map<String, dynamic> additionalBody}) async {
    return await repository.register(body, additionalBody: additionalBody);
  }

  // @override
  // Future<Either<String, String>> call(RegisterRequestBody body) async {
  //   return await repository.register(body);
  // }
}
