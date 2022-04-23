import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/data/models/user_model.dart';
import 'package:pundi_kita/core/domain/entities/user_entity.dart';

class ProfileResponseModel extends Equatable {
  final int status;
  final User data;

  const ProfileResponseModel({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [status, data];

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
        status: json['status'],
        data: UserModel.fromJson(json['data']),
      );
}
