import 'package:dio/dio.dart';

import '../../domain/entities/faq_entity.dart';
import '../../../../core/static/extensions.dart';
import '../models/faq_model.dart';

abstract class FaqDataSource {
  Future<List<Faq>> getFaqList();
}

class FaqDataSourceImplementation implements FaqDataSource {
  final Dio dio;

  FaqDataSourceImplementation({required this.dio});

  @override
  Future<List<Faq>> getFaqList() async {
    const String path = 'api/user/faq/list';
    dio.withToken();
    try {
      final response = await dio.get(path);
      return FaqResponseModel.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }
}
