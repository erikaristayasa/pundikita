import 'package:dartz/dartz.dart';

import '../../domain/entities/setting_entity.dart';
import '../../domain/repositories/setting_repository.dart';
import '../../errors/failure.dart';
import '../../network/network_info.dart';
import '../datasources/setting_data_source.dart';

class SettingRepositoryImplementation implements SettingRepository {
  final SettingDataSource dataSource;
  final NetworkInfo networkInfo;

  SettingRepositoryImplementation({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Setting>> getSetting() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getSetting();
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }
}
