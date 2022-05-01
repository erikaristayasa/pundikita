import 'package:equatable/equatable.dart';

import 'campaign_model.dart';

class CampaignTypeResponseModel extends Equatable {
  final int status;
  final List<CampaignTypeModel> data;

  const CampaignTypeResponseModel({required this.status, required this.data});

  @override
  List<Object?> get props => [status, data];

  factory CampaignTypeResponseModel.fromJson(Map<String, dynamic> json) => CampaignTypeResponseModel(
        status: json['status'],
        data: List<CampaignTypeModel>.from(json['data'].map((x) => CampaignTypeModel.fromJson(x))),
      );
}
