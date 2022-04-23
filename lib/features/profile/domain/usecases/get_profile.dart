import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/profile_repository.dart';

abstract class GetProfileUseCase<Type> {
  Future<Either<Failure, User>> call();
}

class GetProfile implements GetProfileUseCase<User> {
  final ProfileRepository repository;

  GetProfile(this.repository);

  @override
  Future<Either<Failure, User>> call() async {
    return await repository.getProfile();
  }
}
