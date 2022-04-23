import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/errors/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getProfile();
  Future<Either<Failure, bool>> updateProfile(FormData data);
}
