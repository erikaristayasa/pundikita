import 'package:dio/dio.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../domain/entities/campaign_entity.dart';
import '../../static/enums.dart';
import '../../static/extensions.dart';
import '../models/campaign_detail_response_model.dart';
import '../models/campaign_list_response_model.dart';

abstract class CampaignDataSource {
  Future<List<Campaign>> getCampaignList(CampaignService service, {bool auth});
  Future<Campaign> getCampaignDetail(int id, {required CampaignService service});
}

class CampaignDataSourceImplementation implements CampaignDataSource {
  final Dio dio;

  CampaignDataSourceImplementation({required this.dio});

  @override
  Future<Campaign> getCampaignDetail(int id, {required CampaignService service}) async {
    String path = '';
    switch (service) {
      case CampaignService.donasi:
        path = 'api/user/campaign/find/$id';
        break;
      case CampaignService.zakat:
        path = 'api/user/zakat/find/$id';
        break;
    }
    dio.withToken();

    try {
      final response = await dio.get(path);
      final model = CampaignDetailResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Campaign>> getCampaignList(CampaignService service, {bool auth = false}) async {
    String path = '';
    switch (service) {
      case CampaignService.donasi:
        path = auth ? 'api/user/campaign/list-by-auth' : 'api/user/campaign/list';
        break;
      case CampaignService.zakat:
        path = 'api/user/zakat/list';
        break;
    }
    dio.withToken();

    try {
      final response = await dio.get(path);
      final model = CampaignListResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }
}
