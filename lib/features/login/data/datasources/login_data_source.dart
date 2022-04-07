import 'package:dio/dio.dart';

import '../models/login_response_model.dart';

abstract class LoginDataSource {
  Future<LoginResponseModel> login({String? email, String? password});
}

class LoginDataSourceImplementation implements LoginDataSource {
  final Dio dio;

  LoginDataSourceImplementation({required this.dio});

  @override
  Future<LoginResponseModel> login({String? email, String? password}) async {
    const path = 'api//user/login';
    final data = FormData.fromMap({
      'email': email,
      'password': password,
    });

    try {
      final response = await dio.post(path, data: data);
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
