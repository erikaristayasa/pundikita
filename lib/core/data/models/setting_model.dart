import '../../domain/entities/setting_entity.dart';

class SettingResponseModel {
  final int status;
  final SettingModel data;

  SettingResponseModel({
    required this.status,
    required this.data,
  });

  factory SettingResponseModel.fromJson(Map<String, dynamic> json) => SettingResponseModel(
        status: json['status'],
        data: SettingModel.fromJson(json['data']),
      );
}

class SettingModel extends Setting {
  const SettingModel({
    required String termsAndCondition,
    required String privacyPolicy,
    required String aboutUs,
  }) : super(
          termsAndCondition: termsAndCondition,
          privacyPolicy: privacyPolicy,
          aboutUs: aboutUs,
        );

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        termsAndCondition: json['syarat_ketentuan'] ?? '',
        privacyPolicy: json['kebijakan_pribadi'] ?? '',
        aboutUs: json['tentang_kami'] ?? '',
      );
}
