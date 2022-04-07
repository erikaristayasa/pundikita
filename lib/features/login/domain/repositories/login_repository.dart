import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<String, String>> login({String? email, String? password});
}
