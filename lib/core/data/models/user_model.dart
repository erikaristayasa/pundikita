import '../../domain/entities/user_entity.dart';
import '../../static/extensions.dart';

class UserModel extends User {
  const UserModel({
    required num id,
    required String name,
    required String email,
    required DateTime emailVerifiedAt,
    required String phone,
    required DateTime birthDate,
    required String biodata,
    required String photo,
    required String ktpPhoto,
    required String ktpNumber,
    required String ktpName,
    required num saldo,
    required String? googleUid,
    required String? facebookUid,
    required String? firebaseUid,
    required int agencyStatus,
  }) : super(
          id: id,
          name: name,
          email: email,
          emailVerifiedAt: emailVerifiedAt,
          phone: phone,
          birthDate: birthDate,
          biodata: biodata,
          photo: photo,
          ktpPhoto: ktpPhoto,
          ktpNumber: ktpNumber,
          ktpName: ktpName,
          saldo: saldo,
          googleUid: googleUid,
          facebookUid: facebookUid,
          firebaseUid: firebaseUid,
          agencyStatus: agencyStatus,
        );
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['nama'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'].toString().toDate(),
        phone: json['telepon'],
        birthDate: json['tanggal_lahir'].toString().toDate(),
        biodata: json['biodata'],
        photo: json['foto'],
        ktpPhoto: json['foto_ktp'],
        ktpNumber: json['nomor_ktp'],
        ktpName: json['nama_ktp'],
        saldo: json['saldo'],
        googleUid: json['google_uid'],
        facebookUid: json['facebook_uid'],
        firebaseUid: json['firebase_uid'],
        agencyStatus: json['status_lembaga'],
      );
}