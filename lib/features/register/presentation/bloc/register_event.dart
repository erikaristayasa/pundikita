part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmit extends RegisterEvent {
  final XFile photo;
  final String name, email, phone, password, passwordConfirmation;
  final int donatureType;
  final Map<String, dynamic> additonalBody;

  const RegisterSubmit({
    required this.photo,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    required this.donatureType,
    required this.additonalBody,
  });

  @override
  List<Object> get props => [
        photo,
        name,
        email,
        phone,
        password,
        passwordConfirmation,
        donatureType,
        additonalBody,
      ];
}
