import 'package:equatable/equatable.dart';

import 'campaign_model.dart';

class CampaignDetailResponseModel extends Equatable {
  final int status;
  final CampaignModel data;

  const CampaignDetailResponseModel({required this.status, required this.data});

  @override
  List<Object?> get props => [status, data];

  factory CampaignDetailResponseModel.fromJson(Map<String, dynamic> json) => CampaignDetailResponseModel(
        status: json['status'],
        data: CampaignModel.fromJson(json['data']),
      );
}
