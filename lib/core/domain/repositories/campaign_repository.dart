import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../static/enums.dart' as e;
import '../entities/campaign_entity.dart';

abstract class CampaignRepository {
  Future<Either<Failure, List<Campaign>>> getAllCampaignList(e.CampaignService service, {bool auth = false, CampaignCategory? category, bool? sort, String? keyword});
  Future<Either<Failure, Campaign>> getCampaignDetail(int id, {required e.CampaignService service});
  Future<Either<Failure, List<CampaignType>>> getCampaignTypes();
  Future<Either<Failure, List<CampaignCategory>>> getCampaignCategories();
  Future<Either<Failure, List<CampaignSubCategory>>> getCampaignSubCategories(int id);
  Future<Either<Failure, bool>> createCampaign(Map<String, dynamic> body);
}
