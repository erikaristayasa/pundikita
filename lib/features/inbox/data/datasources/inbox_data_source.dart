import 'package:dio/dio.dart';

import '../../../../core/static/extensions.dart';
import '../../domain/entities/inbox.dart';
import '../models/inbox_list_response_model.dart';

abstract class InboxDataSource {
  Future<List<Inbox>> getInboxList();
}

class InboxDataSourceImplementation implements InboxDataSource {
  final Dio dio;

  InboxDataSourceImplementation({required this.dio});

  @override
  Future<List<Inbox>> getInboxList() async {
    const path = 'api/user/news/list';
    dio.withToken();

    try {
      final response = await dio.get(path);
      final model = InboxListResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }
}
