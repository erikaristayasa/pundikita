import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class RegisterRequestBody extends Equatable {
  final XFile photo;
  final String name, email, password, passwordConfirmation, phone;
  final int donatureType;

  const RegisterRequestBody({
    required this.photo,
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
    required this.donatureType,
  });

  @override
  List<Object?> get props => [
        photo,
        name,
        email,
        password,
        passwordConfirmation,
        phone,
        donatureType,
      ];
  Future<Map<String, dynamic>> toJson() async => {
        'photo': await MultipartFile.fromFile(photo.path, filename: photo.name),
        'nama': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'telepon': phone,
        'tipe_donature': donatureType,
      };
}
