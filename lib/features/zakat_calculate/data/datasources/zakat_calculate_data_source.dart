import 'package:dio/dio.dart';

import '../../../../core/static/extensions.dart';
import '../models/zakat_calculate_response_model.dart';

abstract class ZakatCalculateDataSource {
  Future<num> calculate(int monthlyIncome, int monthlyOtherIncome, int monthlyInstallmentDebt);
}

class ZakatCalculateDataSourceImplementation implements ZakatCalculateDataSource {
  final Dio dio;

  ZakatCalculateDataSourceImplementation({required this.dio});

  @override
  Future<num> calculate(int monthlyIncome, int monthlyOtherIncome, int monthlyInstallmentDebt) async {
    const path = 'api/user/zakat/calculate/profesi';
    final data = FormData.fromMap({
      'penghasilan_perbulan': monthlyIncome,
      'penghasilan_lain_perbulan': monthlyOtherIncome,
      'utang_cicilan_perbulan': monthlyInstallmentDebt,
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
