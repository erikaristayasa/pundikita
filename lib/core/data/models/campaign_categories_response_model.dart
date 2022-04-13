import 'package:equatable/equatable.dart';

import 'campaign_model.dart';

class CampaignCategoriesResponseModel extends Equatable {
  final int status;
  final List<CampaignCategoryModel> data;

  const CampaignCategoriesResponseModel({required this.status, required this.data});

  @override
  List<Object?> get props => [status, data];

  factory CampaignCategoriesResponseModel.fromJson(Map<String, dynamic> json) => CampaignCategoriesResponseModel(
        status: json['status'],
        data: json['data'] != null ? List<CampaignCategoryModel>.from(json['data'].map((x) => CampaignCategoryModel.fromJson(x))) : [],
      );
}
