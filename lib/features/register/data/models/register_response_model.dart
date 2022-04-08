class RegisterResponseModel {
  final int status;
  final String? data;

  RegisterResponseModel({required this.status, this.data});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(status: json['status'], data: json['data']);
}
