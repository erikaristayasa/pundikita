import 'package:dio/dio.dart';

import '../../../../core/static/extensions.dart';
import '../models/zakat_calculate_response_model.dart';

abstract class ZakatCalculateDataSource {
  Future<num> calculate(int monthlyIncome, int monthlyOtherIncome, int monthlyInstallmentDebt);
  Future<num> calculateMaal({
    required int giroSavingsDepositValue,
    required int vehiclePropertyValue,
    required int goldSilverGgemsOrOthers,
    required int sharesReceivablesAndOtherSecurities,
    required int personalDebtDueThisYear,
  });
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

  @override
  Future<num> calculateMaal({
    required int giroSavingsDepositValue,
    required int vehiclePropertyValue,
    required int goldSilverGgemsOrOthers,
    required int sharesReceivablesAndOtherSecurities,
    required int personalDebtDueThisYear,
  }) async {
    const path = 'api/user/zakat/calculate/maal';
    final data = FormData.fromMap({
      'nilai_deposito_tabungan_giro': giroSavingsDepositValue,
      'nilai_properti_kendaraan': vehiclePropertyValue,
      'emas_perak_permata_atau_sejenisnya': goldSilverGgemsOrOthers,
      'saham_piutang_dan_surat_surat_berharga_lainnya': sharesReceivablesAndOtherSecurities,
      'hutang_pribadi_yang_jatuh_tempo_tahun_ini': personalDebtDueThisYear,
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
