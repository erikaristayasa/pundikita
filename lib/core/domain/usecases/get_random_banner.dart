import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../entities/banner_entity.dart';
import '../repositories/banner_repository.dart';

abstract class SingleBannerUseCase<Type> {
  Future<Either<Failure, Banner>> call();
}

class GetRandomBanner implements SingleBannerUseCase<Banner> {
  final BannerRepository repository;

  GetRandomBanner(this.repository);

  @override
  Future<Either<Failure, Banner>> call() async {
    return await repository.getRandomBanner();
  }
}
