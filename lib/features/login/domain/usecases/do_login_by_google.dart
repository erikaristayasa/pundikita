import 'package:dartz/dartz.dart';
import 'package:pundi_kita/features/login/domain/repositories/login_repository.dart';

abstract class LoginByGoogleUseCase<Type> {
  Future<Either<String, String>> call({
    String? email,
    String? name,
    String? googleUid,
    String? phone,
  });
}

class DoLoginByGoogle implements LoginByGoogleUseCase<String> {
  final LoginRepository repository;

  DoLoginByGoogle(this.repository);

  @override
  Future<Either<String, String>> call({
    String? email,
    String? name,
    String? googleUid,
    String? phone,
  }) async {
    return await repository.loginByGoogle(
      email: email,
      name: name,
      googleUid: googleUid,
      phone: phone,
    );
  }
}
