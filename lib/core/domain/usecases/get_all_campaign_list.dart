import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../static/enums.dart';
import '../entities/campaign_entity.dart';
import '../repositories/campaign_repository.dart';

abstract class CampaignListUseCase<Type> {
  Future<Either<Failure, List<Campaign>>> call(CampaignService service, {bool auth, CampaignCategory? category, bool? sort, String? keyword});
}

class GetAllCampaignList extends CampaignListUseCase<List<Campaign>> {
  final CampaignRepository repository;

  GetAllCampaignList(this.repository);

  @override
  Future<Either<Failure, List<Campaign>>> call(CampaignService service, {bool auth = false, CampaignCategory? category, bool? sort, String? keyword}) async {
    return await repository.getAllCampaignList(
      service,
      auth: auth,
      category: category,
      sort: sort,
      keyword: keyword,
    );
  }
}
