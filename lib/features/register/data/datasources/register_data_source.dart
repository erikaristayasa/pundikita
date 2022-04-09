import 'package:dio/dio.dart';

import '../../../../core/data/models/common_response.model.dart';
import '../../domain/entities/register_request_body.dart';

abstract class RegisterDataSource {
  Future<CommonResponseModel> register(RegisterRequestBody body);
}

class RegisterDataSourceImplementation implements RegisterDataSource {
  final Dio dio;

  RegisterDataSourceImplementation({required this.dio});

  @override
  Future<CommonResponseModel> register(RegisterRequestBody body) async {
    const path = 'api/user/register';
    final data = FormData.fromMap(body.toJson());

    try {
      final response = await dio.post(path, data: data);
      return CommonResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
