import 'package:dio/dio.dart';
import 'package:pundi_kita/core/data/models/banner_single_response_model.dart';

import '../../static/extensions.dart';
import '../../domain/entities/banner_entity.dart';
import '../models/banner_list_response_model.dart';

abstract class BannerDataSource {
  Future<List<Banner>> getBanners();
  Future<Banner> getRandomBanner();
}

class BannerDataSourceImplementation implements BannerDataSource {
  final Dio dio;

  BannerDataSourceImplementation({required this.dio});

  @override
  Future<List<Banner>> getBanners() async {
    const String path = 'api/user/banner/list';
    dio.withToken();

    try {
      final response = await dio.get(path);
      return BannerListResponseModel.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Banner> getRandomBanner() async {
    const String path = 'api/user/banner/random';
    dio.withToken();

    try {
      final response = await dio.get(path);
      return BannerSingleResponseModel.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }
}
