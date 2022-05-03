import 'package:equatable/equatable.dart';

import 'campaign_model.dart';

class CampaignSubCategoryResponseModel extends Equatable {
  final int status;
  final List<CampaignSubCategoryModel> data;

  const CampaignSubCategoryResponseModel({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [status, data];

  factory CampaignSubCategoryResponseModel.fromJson(Map<String, dynamic> json) => CampaignSubCategoryResponseModel(
        status: json['status'],
        data: List<CampaignSubCategoryModel>.from(json['data'].map((x) => CampaignSubCategoryModel.fromJson(x))),
      );
}
