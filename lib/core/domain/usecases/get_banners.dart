import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../entities/banner_entity.dart';
import '../repositories/banner_repository.dart';

abstract class BannerUseCase<Type> {
  Future<Either<Failure, List<Banner>>> call();
}

class GetBanners implements BannerUseCase<List<Banner>> {
  final BannerRepository repository;

  GetBanners(this.repository);

  @override
  Future<Either<Failure, List<Banner>>> call() async {
    return await repository.getBanners();
  }
}
