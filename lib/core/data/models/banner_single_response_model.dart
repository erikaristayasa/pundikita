import 'package:equatable/equatable.dart';

import 'banner_model.dart';

class BannerSingleResponseModel extends Equatable {
  final int status;
  final BannerModel data;

  const BannerSingleResponseModel({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [
        status,
        data,
      ];
  factory BannerSingleResponseModel.fromJson(Map<String, dynamic> json) => BannerSingleResponseModel(
        status: json['status'],
        data: BannerModel.fromJson(json['data']),
      );
}
