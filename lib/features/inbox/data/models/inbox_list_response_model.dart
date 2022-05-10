import 'package:equatable/equatable.dart';

import 'inbox_model.dart';

class InboxListResponseModel extends Equatable {
  final int status;
  final List<InboxModel> data;

  const InboxListResponseModel({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [status, data];

  factory InboxListResponseModel.fromJson(Map<String, dynamic> json) => InboxListResponseModel(
        status: json['status'],
        data: List<InboxModel>.from(json['data'].map((x) => InboxModel.fromJson(x))),
      );
}
