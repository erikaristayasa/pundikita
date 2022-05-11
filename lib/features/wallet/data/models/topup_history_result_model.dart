import 'package:pundi_kita/features/wallet/data/models/topup_result_model.dart';

class TopUpHistoryResultModel {
  final int status;
  final List<TopUpResultModel> data;

  TopUpHistoryResultModel({
    required this.status,
    required this.data,
  });

  factory TopUpHistoryResultModel.fromJson(Map<String, dynamic> json) => TopUpHistoryResultModel(
        status: json['status'],
        data: List<TopUpResultModel>.from(json['data'].map((x) => TopUpResultModel.fromJson(x))),
      );
}
