import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_data_source.dart';

class ProfileRepositoryImplementation implements ProfileRepository {
  final ProfileDataSource dataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImplementation({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getProfile();
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }

  @override
  Future<Either<Failure, bool>> updateProfile(FormData data) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.updateProfile(data);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }
}
