import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../static/enums.dart';
import '../entities/campaign_entity.dart';

abstract class CampaignRepository {
  Future<Either<Failure, List<Campaign>>> getAllCampaignList(CampaignService service, {bool auth = false, CampaignCategory? category, bool? sort});
  Future<Either<Failure, Campaign>> getCampaignDetail(int id, {required CampaignService service});
  Future<Either<Failure, List<CampaignType>>> getCampaignTypes();
  Future<Either<Failure, List<CampaignCategory>>> getCampaignCategories();
  Future<Either<Failure, List<CampaignSubCategory>>> getCampaignSubCategories(int id);
}
