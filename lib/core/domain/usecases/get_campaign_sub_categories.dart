import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../entities/campaign_entity.dart';
import '../repositories/campaign_repository.dart';

abstract class CampaignSubCategoryUseCase<Type> {
  Future<Either<Failure, List<CampaignSubCategory>>> call(int id);
}

class GetCampaignSubCategories implements CampaignSubCategoryUseCase {
  final CampaignRepository repository;

  GetCampaignSubCategories(this.repository);

  @override
  Future<Either<Failure, List<CampaignSubCategory>>> call(int id) async {
    return await repository.getCampaignSubCategories(id);
  }
}
