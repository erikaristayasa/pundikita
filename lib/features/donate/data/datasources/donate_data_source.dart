import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';

abstract class DonateDataSource {
  Future<bool> requestInquiry(Map<String, dynamic> request, {CampaignService? service});
}

class DonateDateSourceImplementation implements DonateDataSource {
  final Dio dio;

  DonateDateSourceImplementation({required this.dio});

  @override
  Future<bool> requestInquiry(Map<String, dynamic> request, {CampaignService? service}) async {
    String path = 'api/user/campaign/donation/create';
    if (service == CampaignService.zakat) {
      path = 'api/user/zakat/donation/create';
    }
    final data = FormData.fromMap(request);
    dio.withToken();

    try {
      final response = await dio.post(path, data: data);
      return response.statusCode == HttpStatus.ok;
    } catch (e) {
      rethrow;
    }
  }
}
