import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<String, String>> login({String? email, String? password});
  Future<Either<String, String>> loginByGoogle({
    String? email,
    String? name,
    String? googleUid,
    String? phone,
  });
}
