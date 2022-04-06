import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:pundi_kita/core/network/app_interceptor.dart';
import 'package:pundi_kita/core/static/config.dart';

class DioClient {
  late Dio dio;
  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: Config.BASE_URL,
      followRedirects: false,
      validateStatus: (status) => (status == 200),
    ));
    dio.interceptors.addAll([AppInterceptor(), DioLoggingInterceptor()]);
  }
}
