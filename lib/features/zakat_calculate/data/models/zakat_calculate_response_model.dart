import 'package:equatable/equatable.dart';

class ZakatCalculateResponseModel extends Equatable {
  final int status;
  final num data;

  const ZakatCalculateResponseModel({
    required this.status,
    required this.data,
  });
  @override
  List<Object?> get props => [status, data];

  factory ZakatCalculateResponseModel.fromJson(Map<String, dynamic> json) => ZakatCalculateResponseModel(
        status: json['status'],
        data: json['data'],
      );
}
