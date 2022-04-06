import 'dart:async';

import 'package:dio/dio.dart';

import '../utility/shared_preferences_helper.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('token')) {
      options.headers.remove('token');

      // get session token
      final session = await SharedPreferencesHelper().init();
      options.headers.addAll({'Authorization': 'Bearer ${session.userToken}'});
    }
    return super.onRequest(options, handler);
  }
}
