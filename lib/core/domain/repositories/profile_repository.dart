import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/user_entity.dart';
import '../../errors/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getProfile();
  Future<Either<Failure, bool>> updateProfile(FormData data);
}
