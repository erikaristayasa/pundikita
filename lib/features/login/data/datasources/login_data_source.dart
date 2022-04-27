import 'package:dio/dio.dart';

import '../../../../core/data/models/common_response.model.dart';

abstract class LoginDataSource {
  Future<CommonResponseModel> login({String? email, String? password});
  Future<CommonResponseModel> loginByGoogle({
    String? email,
    String? name,
    String? googleUid,
    String? phone,
  });
}

class LoginDataSourceImplementation implements LoginDataSource {
  final Dio dio;

  LoginDataSourceImplementation({required this.dio});

  @override
  Future<CommonResponseModel> login({String? email, String? password}) async {
    const path = 'api/user/login';
    final data = FormData.fromMap({
      'email': email,
      'password': password,
    });

    try {
      final response = await dio.post(path, data: data);
      return CommonResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommonResponseModel> loginByGoogle({String? email, String? name, String? googleUid, String? phone}) async {
    const path = 'api/user/login/google';
    final data = FormData.fromMap({
      'google_uid': googleUid,
      'name': name,
      'email': email,
      'phone': phone,
    });

    try {
      final response = await dio.post(path, data: data);
      return CommonResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
