import 'package:dartz/dartz.dart';
import 'package:pundi_kita/core/domain/repositories/campaign_repository.dart';

import '../../errors/failure.dart';
import '../../static/enums.dart';
import '../entities/campaign_entity.dart';

abstract class CampaignDetailUseCase<Type> {
  Future<Either<Failure, Campaign>> call(int id, {required CampaignService service});
}

class GetCampaignDetail implements CampaignDetailUseCase<Campaign> {
  final CampaignRepository repository;

  GetCampaignDetail(this.repository);

  @override
  Future<Either<Failure, Campaign>> call(int id, {required CampaignService service}) async {
    return await repository.getCampaignDetail(id, service: service);
  }
}
