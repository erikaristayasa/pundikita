import 'package:dartz/dartz.dart';
import 'package:pundi_kita/core/domain/entities/campaign_entity.dart';
import 'package:pundi_kita/core/domain/repositories/campaign_repository.dart';

import '../../errors/failure.dart';

abstract class CampaignCategoryUseCase<Type> {
  Future<Either<Failure, List<CampaignCategory>>> call();
}

class GetCampaignCategories implements CampaignCategoryUseCase<List<CampaignCategory>> {
  final CampaignRepository repository;

  GetCampaignCategories(this.repository);

  @override
  Future<Either<Failure, List<CampaignCategory>>> call() async {
    return await repository.getCampaignCategories();
  }
}
