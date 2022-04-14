import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../static/enums.dart';
import 'user_entity.dart';

class Campaign extends Equatable {
  final int id;
  final CampaignService campaignService;
  final int? userId;
  final int? campaignTypeId;
  final int? campaignCategoryId;
  final int? campaignSubCategoryid;
  final int? organizer;
  final String? title;
  final DateTime? endDate;
  final num amountOfFunds;
  final num amountOfCollectedFunds;
  final String? phone;
  final String? patientPhone;
  final String? photo;
  final String? story;
  final String? sortInvitation;
  final String? patienIdPhoto;
  final String? medicalCertificatePhoto;
  final String? medicalResultPhoto;
  final String? patientName;
  final String? patientSickness;
  final bool? hospitalizationStatus;
  final String? hospitalName;
  final String? treatmentEfforts;
  final String? treatmentSources;
  final String? ktpName;
  final String? job;
  final String? schoolOrWorkName;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? linkkedInUrl;
  final String? eventName;
  final String? eventGoal;
  final String? eventAddress;
  final String? detailOfUseOfFunds;
  final int status;
  final User? user;
  // final dynamic recipientStatus;
  // final bool personalRecipientStatus;
  // final String? personalRecipientName;
  // final String? personalRecipientAddress;
  // final String? personalRecipientKtpPhoto;
  // final String? personalRecipientKtpNumber;
  // final String? personalRecipientKtpName;
  // final String? personalRecipientKtpBirthPlace;
  // final DateTime? personalRecipientKtpBirthDate;
  // final String? personalRecipientKtpGender;
  final CampaignType? campaignType;
  final CampaignCategory? campaignCategory;
  final CampaignSubCategory? campaignSubCategory;
  final List<CampaignDonation> donation;

  const Campaign({
    required this.id,
    required this.campaignService,
    required this.userId,
    required this.campaignTypeId,
    required this.campaignCategoryId,
    required this.campaignSubCategoryid,
    required this.organizer,
    required this.title,
    required this.endDate,
    required this.amountOfFunds,
    required this.amountOfCollectedFunds,
    required this.phone,
    required this.patientPhone,
    required this.photo,
    required this.story,
    required this.sortInvitation,
    required this.patienIdPhoto,
    required this.medicalCertificatePhoto,
    required this.medicalResultPhoto,
    required this.patientName,
    required this.patientSickness,
    required this.hospitalizationStatus,
    required this.hospitalName,
    required this.treatmentEfforts,
    required this.treatmentSources,
    required this.ktpName,
    required this.job,
    required this.schoolOrWorkName,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.twitterUrl,
    required this.linkkedInUrl,
    required this.eventName,
    required this.eventGoal,
    required this.eventAddress,
    required this.detailOfUseOfFunds,
    required this.status,
    required this.user,
    required this.campaignType,
    required this.campaignCategory,
    required this.campaignSubCategory,
    required this.donation,
  });

  double get progress {
    final result = (amountOfFunds / amountOfCollectedFunds) / 10;
    if (result.isInfinite || result.isNaN) {
      return 0.0;
    }
    return result;
  }

  int get leftDate {
    try {
      final left = daysBetween(DateTime.now(), endDate!);
      return left;
    } catch (e) {
      return 0;
    }
  }

  bool get patientVerified => patienIdPhoto != null;
  bool get patientSicknessVerified => medicalCertificatePhoto != null;

  @override
  List<Object?> get props => [
        id,
        campaignService,
        userId,
        campaignTypeId,
        campaignCategoryId,
        campaignSubCategoryid,
        organizer,
        title,
        endDate,
        amountOfFunds,
        amountOfCollectedFunds,
        phone,
        patientPhone,
        photo,
        story,
        sortInvitation,
        patienIdPhoto,
        medicalCertificatePhoto,
        medicalResultPhoto,
        patientName,
        patientSickness,
        hospitalizationStatus,
        hospitalName,
        treatmentEfforts,
        treatmentSources,
        ktpName,
        job,
        schoolOrWorkName,
        facebookUrl,
        instagramUrl,
        twitterUrl,
        linkkedInUrl,
        eventName,
        eventGoal,
        eventAddress,
        detailOfUseOfFunds,
        status,
        user,
        campaignType,
        campaignCategory,
        campaignSubCategory,
        donation
      ];
}

class CampaignType extends Equatable {
  final int id;
  final String icon;
  final String? title;
  final String? description;

  const CampaignType({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        icon,
        title,
        description,
      ];
}

class CampaignCategory extends Equatable {
  final int id;
  final String? icon;
  final String? categoryName;

  const CampaignCategory({
    required this.id,
    required this.icon,
    required this.categoryName,
  });

  @override
  List<Object?> get props => [
        id,
        icon,
        categoryName,
      ];
}

class CampaignSubCategory extends Equatable {
  final int id;
  final int campaignCategoryId;
  final String? title;
  final String? description;

  const CampaignSubCategory({
    required this.id,
    required this.campaignCategoryId,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        campaignCategoryId,
        title,
        description,
      ];
}

class CampaignDonation extends Equatable {
  final int id;
  final int userId;
  final int campaignId;
  final num amountOfFunds;
  final String? pray;
  final int paymentTransactionId;
  final PaymentMethod paymentMethod;
  final PaymentChannel paymentChannel;
  final String paymentNumber;
  final String paymentName;
  final num paymentTotal;
  final num paymentFee;
  final DateTime? paymentExpired;
  final String? paymentQRImage;
  final int status;
  final bool likeStatus;

  const CampaignDonation({
    required this.id,
    required this.userId,
    required this.campaignId,
    required this.amountOfFunds,
    required this.pray,
    required this.paymentTransactionId,
    required this.paymentMethod,
    required this.paymentChannel,
    required this.paymentNumber,
    required this.paymentName,
    required this.paymentTotal,
    required this.paymentFee,
    required this.paymentExpired,
    required this.paymentQRImage,
    required this.status,
    required this.likeStatus,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        campaignId,
        amountOfFunds,
        pray,
        paymentTransactionId,
        paymentMethod,
        paymentChannel,
        paymentNumber,
        paymentName,
        paymentTotal,
        paymentFee,
        paymentExpired,
        paymentQRImage,
        status,
        likeStatus,
      ];
}
