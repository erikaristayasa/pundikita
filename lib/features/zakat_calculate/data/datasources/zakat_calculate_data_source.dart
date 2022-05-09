import 'package:dio/dio.dart';

import '../../../../core/static/extensions.dart';
import '../models/zakat_calculate_response_model.dart';

abstract class ZakatCalculateDataSource {
  Future<int> calculate(int monthlyIncome, int monthlyOtherIncome);
}

class ZakatCalculateDataSourceImplementation implements ZakatCalculateDataSource {
  final Dio dio;

  ZakatCalculateDataSourceImplementation({required this.dio});

  @override
  Future<int> calculate(int monthlyIncome, int monthlyOtherIncome) async {
    const path = 'api/user/zakat/calculate';
    final data = FormData.fromMap({
      'penghasilan_perbulan': monthlyIncome,
      'penghasilan_lain_perbulan': monthlyOtherIncome,
    });
    dio.withToken();

    try {
      final response = await dio.post(path, data: data);
      final model = ZakatCalculateResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }
}
