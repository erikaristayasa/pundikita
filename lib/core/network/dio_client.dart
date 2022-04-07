import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';

import '../static/config.dart';
import 'app_interceptor.dart';

class DioClient {
  late Dio dio;
  final AppInterceptor appInterceptor = AppInterceptor();
  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: Config.BASE_URL,
      followRedirects: false,
      validateStatus: (status) => (status == 200) || (status == 400),
    ));
    dio.interceptors.addAll([appInterceptor, dioLoggerInterceptor]);
  }
}
