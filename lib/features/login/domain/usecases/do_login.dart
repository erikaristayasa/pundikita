import 'package:dartz/dartz.dart';

import '../repositories/login_repository.dart';

abstract class LoginUseCase<String> {
  Future<Either<String, String>> call({String? email, String? password});
}

class DoLogin implements LoginUseCase<String> {
  final LoginRepository repository;

  DoLogin(this.repository);

  @override
  Future<Either<String, String>> call({String? email, String? password}) async {
    return await repository.login(email: email, password: password);
  }
}
