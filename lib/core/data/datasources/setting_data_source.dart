import 'package:dio/dio.dart';

import '../../domain/entities/setting_entity.dart';
import '../../static/extensions.dart';
import '../models/setting_model.dart';

abstract class SettingDataSource {
  Future<Setting> getSetting();
}

class SettingDataSourceImplementation implements SettingDataSource {
  final Dio dio;

  SettingDataSourceImplementation({required this.dio});

  @override
  Future<Setting> getSetting() async {
    const String path = 'api/user/setting/list';
    dio.withToken();
    try {
      final response = await dio.get(path);
      return SettingResponseModel.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }
}
