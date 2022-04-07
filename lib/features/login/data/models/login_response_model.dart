class LoginResponseModel {
  final int status;
  final String? data;

  LoginResponseModel({required this.status, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(status: json['status'], data: json['data']);
}
