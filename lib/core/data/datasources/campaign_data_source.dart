import 'package:dio/dio.dart';

import '../../domain/entities/campaign_entity.dart';
import '../../static/enums.dart';
import '../../static/extensions.dart';
import '../../utility/helper.dart';
import '../models/campaign_categories_response_model.dart';
import '../models/campaign_detail_response_model.dart';
import '../models/campaign_list_response_model.dart';
import '../models/campaign_sub_category_response_model.dart';
import '../models/campaign_type_response_model.dart';

abstract class CampaignDataSource {
  Future<List<Campaign>> getCampaignList(CampaignService service, {bool auth, CampaignCategory? category, bool? sort});
  Future<Campaign> getCampaignDetail(int id, {required CampaignService service});
  Future<List<CampaignType>> getTypes();
  Future<List<CampaignCategory>> getCategories();
  Future<List<CampaignSubCategory>> getSubCategories(int id);
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
  Future<List<Campaign>> getCampaignList(CampaignService service, {bool auth = false, CampaignCategory? category, bool? sort}) async {
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
    final params = {
      if (category != null) 'campaign_category_id': category.id,
      if (sort != null) 'dana_paling_sedikit': sort,
    };

    try {
      final response = await dio.get(path, queryParameters: params);
      final model = CampaignListResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }

  @override
  Future<List<CampaignCategory>> getCategories() async {
    const path = 'api/user/campaign-category/list';
    dio.withToken();

    try {
      final response = await dio.get(path);
      final model = CampaignCategoriesResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CampaignSubCategory>> getSubCategories(int id) async {
    final path = 'api/user/campaign-sub-category/list-by-category-id/$id';
    dio.withToken();
    try {
      final response = await dio.get(path);
      final model = CampaignSubCategoryResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CampaignType>> getTypes() async {
    const path = 'api/user/campaign-type/list';
    dio.withToken();
    try {
      final response = await dio.get(path);
      final model = CampaignTypeResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }
}
