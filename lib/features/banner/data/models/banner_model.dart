import 'package:pundi_kita/features/banner/domain/entities/banner_entity.dart';

class BannerModel extends Banner {
  const BannerModel({
    required int id,
    required int campaingId,
    required String photo,
  }) : super(
          id: id,
          campaingId: campaingId,
          photo: photo,
        );
  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'],
        campaingId: json['campaign_id'],
        photo: json['foto'] ?? '',
      );
}
