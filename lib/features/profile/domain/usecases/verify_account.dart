import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/domain/repositories/profile_repository.dart';
import 'update_profile.dart';

class VerifyAccount implements UpdateProfileUseCase<bool> {
  final ProfileRepository repository;

  VerifyAccount(this.repository);

  @override
  Future<Either<Failure, bool>> call(FormData data) async {
    return await repository.updateProfile(data);
  }
}
