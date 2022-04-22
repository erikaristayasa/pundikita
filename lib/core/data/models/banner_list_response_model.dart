import 'package:equatable/equatable.dart';

import 'banner_model.dart';

class BannerListResponseModel extends Equatable {
  final int status;
  final List<BannerModel> data;

  const BannerListResponseModel({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [status, data];

  factory BannerListResponseModel.fromJson(Map<String, dynamic> json) => BannerListResponseModel(
        status: json['status'],
        data: json['data'] != null ? List<BannerModel>.from(json['data'].map((x) => BannerModel.fromJson(x))) : [],
      );
}
