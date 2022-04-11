import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../static/enums.dart';
import '../entities/campaign_entity.dart';
import '../repositories/campaign_repository.dart';
import 'get_all_campaign_list.dart';

class GetUserCampaignList extends CampaignListUseCase<List<Campaign>> {
  final CampaignRepository repository;

  GetUserCampaignList(this.repository);

  @override
  Future<Either<Failure, List<Campaign>>> call(CampaignService service) async {
    return await repository.getUserCampaignList(service);
  }
}
