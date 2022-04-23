import 'package:dio/dio.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/static/extensions.dart';
import '../models/profile_response_model.dart';

abstract class ProfileDataSource {
  Future<User> getProfile();
  Future<bool> updateProfile(FormData data);
}

class ProfileDataSourceImplementation implements ProfileDataSource {
  final Dio dio;

  ProfileDataSourceImplementation({required this.dio});

  @override
  Future<User> getProfile() async {
    const path = 'api/user/profile';
    dio.withToken();
    try {
      final response = await dio.get(path);
      final model = ProfileResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateProfile(FormData data) async {
    const path = 'api/user/profile/update';
    dio.withToken();
    try {
      final response = await dio.post(path, data: data);
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }
}
