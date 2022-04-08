import 'package:dio/dio.dart';

import '../../domain/entities/register_request_body.dart';
import '../models/register_response_model.dart';

abstract class RegisterDataSource {
  Future<RegisterResponseModel> register(RegisterRequestBody body);
}

class RegisterDataSourceImplementation implements RegisterDataSource {
  final Dio dio;

  RegisterDataSourceImplementation({required this.dio});

  @override
  Future<RegisterResponseModel> register(RegisterRequestBody body) async {
    const path = 'api/user/register';
    final data = FormData.fromMap(body.toJson());

    try {
      final response = await dio.post(path, data: data);
      return RegisterResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
