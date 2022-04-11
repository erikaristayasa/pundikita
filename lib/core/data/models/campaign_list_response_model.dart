import 'package:equatable/equatable.dart';

import 'campaign_model.dart';

class CampaignListResponseModel extends Equatable {
  final int status;
  final List<CampaignModel> data;

  const CampaignListResponseModel({required this.status, required this.data});

  @override
  List<Object?> get props => [status, data];

  factory CampaignListResponseModel.fromJson(Map<String, dynamic> json) => CampaignListResponseModel(
        status: json['status'],
        data: List<CampaignModel>.from(json['data'].map((x) => CampaignModel.fromJson(x))),
      );
}
