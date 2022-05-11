import 'package:pundi_kita/features/wallet/data/models/topup_result_model.dart';
import 'package:pundi_kita/features/wallet/domain/entities/topup_result_entity.dart';

class TopUpCreateResponseModel {
  final int status;
  final TopUpResult data;

  TopUpCreateResponseModel({
    required this.status,
    required this.data,
  });

  factory TopUpCreateResponseModel.fromJson(Map<String, dynamic> json) => TopUpCreateResponseModel(
        status: json['status'],
        data: TopUpResultModel.fromJson(json['data']),
      );
}
