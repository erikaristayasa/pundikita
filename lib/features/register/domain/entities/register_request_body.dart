import 'package:equatable/equatable.dart';

class RegisterRequestBody extends Equatable {
  final String name, email, password, passwordConfirmation, phone;

  const RegisterRequestBody({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        passwordConfirmation,
        phone,
      ];
  Map<String, dynamic> toJson() => {
        'nama': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'telepon': phone,
      };
}
