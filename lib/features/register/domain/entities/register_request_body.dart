import 'package:equatable/equatable.dart';

class RegisterRequestBody extends Equatable {
  final String name, email, password, passwordConfirmation, phone;
  final int donatureType;

  const RegisterRequestBody({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
    required this.donatureType,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        passwordConfirmation,
        phone,
        donatureType,
      ];
  Map<String, dynamic> toJson() => {
        'nama': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'telepon': phone,
        'tipe_donature': donatureType,
      };
}
