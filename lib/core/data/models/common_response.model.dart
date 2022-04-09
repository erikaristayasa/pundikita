import 'package:equatable/equatable.dart';

class CommonResponseModel extends Equatable {
  final int status;
  final String? data;

  const CommonResponseModel({required this.status, required this.data});

  @override
  List<Object?> get props => [status, data];

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) => CommonResponseModel(status: json['status'], data: json['data']);
}
