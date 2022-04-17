import 'package:equatable/equatable.dart';

import 'donation_model.dart';

class RequestInquiryResponseModel extends Equatable {
  final int status;
  final DonationModel data;

  const RequestInquiryResponseModel({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [];

  factory RequestInquiryResponseModel.fromJson(Map<String, dynamic> json) => RequestInquiryResponseModel(
        status: json['status'],
        data: DonationModel.fromJson(json['data']),
      );
}
