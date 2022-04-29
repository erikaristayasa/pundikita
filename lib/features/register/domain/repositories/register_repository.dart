import 'package:dartz/dartz.dart';

import '../entities/register_request_body.dart';

abstract class RegisterRepository {
  Future<Either<String, String>> register(RegisterRequestBody body, {required Map<String, dynamic> additionalBody});
}
