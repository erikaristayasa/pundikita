import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../static/enums.dart';
import '../entities/campaign_entity.dart';
import '../repositories/campaign_repository.dart';
import 'get_all_campaign_list.dart';

class SearchCampaign implements CampaignListUseCase<List<Campaign>> {
  final CampaignRepository repository;

  SearchCampaign(this.repository);

  @override
  Future<Either<Failure, List<Campaign>>> call(CampaignService? service, {bool auth = false, CampaignCategory? category, bool? sort, String? keyword}) async {
    try {
      // get donasi
      final _donation = await getCampaignData(keyword, service: CampaignService.donasi);
      // get zakat
      final _zakat = await getCampaignData(keyword, service: CampaignService.zakat);
      // merger
      final _merger = _donation..addAll(_zakat);
      return Right(_merger);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<List<Campaign>> getCampaignData(String? keyword, {required CampaignService service}) async {
    final result = await repository.getAllCampaignList(service, auth: false, keyword: keyword);
    if (result.isRight()) {
      return result.getOrElse(() => []);
    } else {
      return [];
    }
  }
}
