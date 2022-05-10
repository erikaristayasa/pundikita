import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/domain/repositories/profile_repository.dart';

abstract class UpdateProfileUseCase<Type> {
  Future<Either<Failure, bool>> call(FormData data);
}

class UpdateProfile implements UpdateProfileUseCase<bool> {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  @override
  Future<Either<Failure, bool>> call(FormData data) async {
    return await repository.updateProfile(data);
  }
}
