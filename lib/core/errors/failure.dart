import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ConnectionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class RequestFailure extends Failure {
  final String message;

  RequestFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
