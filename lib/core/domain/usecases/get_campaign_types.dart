import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../entities/campaign_entity.dart';
import '../repositories/campaign_repository.dart';

abstract class CampaignTypeUseCase<Type> {
  Future<Either<Failure, List<CampaignType>>> call();
}

class GetCampaignTypes implements CampaignTypeUseCase<List<CampaignType>> {
  final CampaignRepository repository;

  GetCampaignTypes(this.repository);

  @override
  Future<Either<Failure, List<CampaignType>>> call() async {
    return await repository.getCampaignTypes();
  }
}
