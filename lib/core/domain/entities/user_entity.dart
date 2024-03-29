import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/static/enums.dart';

class User extends Equatable {
  final num id;
  final String? name;
  final String? email;
  final DateTime? emailVerifiedAt;
  final String? phone;
  final DateTime? birthDate;
  final String? biodata;
  final String? photo;
  final String? ktpPhoto;
  final String? ktpNumber;
  final String? ktpName;
  final num? saldo;
  final String? googleUid;
  final String? facebookUid;
  final String? firebaseUid;
  // final int? agencyStatus;
  final bool campaignStatus;
  final bool personalVerified;
  final bool foundationVerified;
  final DonatureType donatureType;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.phone,
    required this.birthDate,
    required this.biodata,
    required this.photo,
    required this.ktpPhoto,
    required this.ktpNumber,
    required this.ktpName,
    required this.saldo,
    required this.googleUid,
    required this.facebookUid,
    required this.firebaseUid,
    // required this.agencyStatus,
    required this.campaignStatus,
    required this.personalVerified,
    required this.foundationVerified,
    required this.donatureType,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        emailVerifiedAt,
        phone,
        birthDate,
        biodata,
        photo,
        ktpPhoto,
        ktpNumber,
        ktpName,
        saldo,
        googleUid,
        facebookUid,
        firebaseUid,
        // agencyStatus,
        campaignStatus,
        personalVerified,
        foundationVerified,
        donatureType,
      ];
}
