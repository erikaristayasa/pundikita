import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/data/models/donation_model.dart';

class DonationListResponseModel extends Equatable {
  final int status;
  final List<DonationModel> data;

  const DonationListResponseModel({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [status, data];

  factory DonationListResponseModel.fromJson(Map<String, dynamic> json) => DonationListResponseModel(
        status: json['status'],
        data: List<DonationModel>.from(json['data'].map((x) => DonationModel.fromJson(x))),
      );
}
