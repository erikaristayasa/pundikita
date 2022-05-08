import 'package:dio/dio.dart';

import '../../domain/entities/donation_entity.dart';
import '../../static/enums.dart';
import '../../static/extensions.dart';
import '../models/donation_list_response_model.dart';
import '../models/request_inquiry_response_model.dart';

abstract class DonateDataSource {
  Future<Donation> requestInquiry(Map<String, dynamic> request, {CampaignService? service});
  Future<List<Donation>> getDonationList({CampaignService? service});
  Future<bool> like({required int donationId});
  Future<bool> unlike({required int donationId});
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

  @override
  Future<List<Donation>> getDonationList({CampaignService? service}) async {
    String path = 'api/user/campaign/donation/list';
    if (service == CampaignService.zakat) {
      path = 'api/user/zakat/donation/list';
    }
    dio.withToken();
    try {
      final response = await dio.get(path);
      final model = DonationListResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> like({required int donationId}) async {
    final path = 'api/user/campaign/donation/like/$donationId';
    dio.withToken();
    try {
      final response = await dio.get(path);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> unlike({required int donationId}) async {
    final path = 'api/user/campaign/donation/unlike/$donationId';
    dio.withToken();
    try {
      final response = await dio.get(path);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
