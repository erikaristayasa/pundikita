import 'package:dio/dio.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../../../core/data/models/common_response.model.dart';
import '../../domain/entities/register_request_body.dart';

abstract class RegisterDataSource {
  Future<CommonResponseModel> register(RegisterRequestBody body, {required Map<String, dynamic> additionalBody});
}

class RegisterDataSourceImplementation implements RegisterDataSource {
  final Dio dio;

  RegisterDataSourceImplementation({required this.dio});

  @override
  Future<CommonResponseModel> register(RegisterRequestBody body, {required Map<String, dynamic> additionalBody}) async {
    const path = 'api/user/register';
    final finalMap = await body.toJson();
    finalMap.addAll(additionalBody);
    final data = FormData.fromMap(finalMap);
    try {
      final response = await dio.post(path, data: data);
      return CommonResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
