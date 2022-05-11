import 'package:dio/dio.dart';

import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../../domain/entities/topup_result_entity.dart';
import '../models/topup_history_result_model.dart';

abstract class WalletDataSource {
  Future<List<TopUpResult>> getTopUpHistories();
  Future<TopUpResult> topUp({
    required String amount,
    required PaymentMethod paymentMethod,
    required PaymentChannel paymentChannel,
  });
}

class WalletDataSourceImplementation implements WalletDataSource {
  final Dio dio;

  WalletDataSourceImplementation({required this.dio});

  @override
  Future<List<TopUpResult>> getTopUpHistories() async {
    const path = 'api/user/top-up/list';
    dio.withToken();
    try {
      final response = await dio.get(path);
      final model = TopUpHistoryResultModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TopUpResult> topUp({required String amount, required PaymentMethod paymentMethod, required PaymentChannel paymentChannel}) {
    // TODO: implement topUp
    throw UnimplementedError();
  }
}
