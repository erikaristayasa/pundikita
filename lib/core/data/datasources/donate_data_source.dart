import 'package:dio/dio.dart';

import '../../domain/entities/donation_entity.dart';
import '../../static/enums.dart';
import '../../static/extensions.dart';
import '../models/request_inquiry_response_model.dart';

abstract class DonateDataSource {
  Future<Donation> requestInquiry(Map<String, dynamic> request, {CampaignService? service});
}

class DonateDateSourceImplementation implements DonateDataSource {
  final Dio dio;

  DonateDateSourceImplementation({required this.dio});

  @override
  Future<Donation> requestInquiry(Map<String, dynamic> request, {CampaignService? service}) async {
    String path = 'api/user/campaign/donation/create';
    if (service == CampaignService.zakat) {
      path = 'api/user/zakat/donation/create';
    }
    final data = request;
    dio.withToken();

    try {
      final response = await dio.post(path, data: data);
      final model = RequestInquiryResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }
}
