import 'package:dio/dio.dart';

import '../../../../core/data/models/common_response.model.dart';

abstract class ForgotPasswordDataSource {
  Future<CommonResponseModel> forgotPassword(String email);
}

class ForgotPasswordDataSourceImplementation implements ForgotPasswordDataSource {
  final Dio dio;

  ForgotPasswordDataSourceImplementation({required this.dio});

  @override
  Future<CommonResponseModel> forgotPassword(String email) async {
    const path = 'api/forgot-password';
    final data = FormData.fromMap({'email': email});

    try {
      final response = await dio.post(path, data: data);
      return CommonResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
