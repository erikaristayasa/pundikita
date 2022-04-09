import 'package:dio/dio.dart';

import '../../../../core/data/models/common_response.model.dart';

abstract class LoginDataSource {
  Future<CommonResponseModel> login({String? email, String? password});
}

class LoginDataSourceImplementation implements LoginDataSource {
  final Dio dio;

  LoginDataSourceImplementation({required this.dio});

  @override
  Future<CommonResponseModel> login({String? email, String? password}) async {
    const path = 'api//user/login';
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
}
