part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmit extends RegisterEvent {
  final String name, email, phone, password, passwordConfirmation;

  const RegisterSubmit({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [
        name,
        email,
        phone,
        password,
        passwordConfirmation,
      ];
}
