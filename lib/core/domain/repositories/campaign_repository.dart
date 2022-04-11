import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../static/enums.dart';
import '../entities/campaign_entity.dart';

abstract class CampaignRepository {
  Future<Either<Failure, List<Campaign>>> getAllCampaignList(CampaignService service);
  Future<Either<Failure, List<Campaign>>> getUserCampaignList(CampaignService service);
  Future<Either<Failure, Campaign>> getCampaignDetail(int id, {required CampaignService service});
}
