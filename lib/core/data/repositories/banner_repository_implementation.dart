import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../network/network_info.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/repositories/banner_repository.dart';
import '../datasources/banner_data_source.dart';

class BannerRepositoryImplementation implements BannerRepository {
  final BannerDataSource dataSource;
  final NetworkInfo networkInfo;

  BannerRepositoryImplementation({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Banner>>> getBanners() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await dataSource.getBanners());
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }
}
