import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../entities/banner_entity.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<Banner>>> getBanners();
  Future<Either<Failure, Banner>> getRandomBanner();
}
