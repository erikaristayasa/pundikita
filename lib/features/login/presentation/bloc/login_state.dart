part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});

  @override
  List<Object> get props => [message];
}

// class LoginInitial extends LoginState {
//   final String? email;
//   final String? password;

//   const LoginInitial({this.email, this.password});

//   LoginState copyWith({
//     String? email,
//     String? password,
//   }) =>
//       LoginInitial(
//         email: email ?? this.email,
//         password: password ?? this.password,
//       );
// }


