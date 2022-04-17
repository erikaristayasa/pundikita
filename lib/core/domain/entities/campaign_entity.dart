import 'package:equatable/equatable.dart';

import '../../static/enums.dart';
import '../../utility/helper.dart';
import 'donation_entity.dart';
import 'user_entity.dart';

class Campaign extends Equatable {
  final int id;
  final int? userId;
  final int? campaignTypeId;
  final int? campaignCategoryId;
  final int? campaignSubCategoryid;
  final int? organizer;

  // campaing basic info
  final String? title;
  final String? photo;
  final CampaignService campaignService;
  final DateTime? endDate;
  final num amountOfFunds;
  final num amountOfCollectedFunds;
  final String? phone;
  final String? story;
  final String? sortInvitation;
  final String? detailOfUseOfFunds;
  final int status;

  // patient info
  final String? patientPhone;
  final String? patientName;
  final String? patientSickness;
  final String? patienIdPhoto;
  final String? medicalCertificatePhoto;
  final String? medicalResultPhoto;
  final bool? hospitalizationStatus;
  final String? hospitalName;
  final String? treatmentEfforts;
  final String? treatmentSources;
  final String? ktpName;
  final String? job;
  final String? schoolOrWorkName;

  // social media info
  final String? facebookUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? linkkedInUrl;

  // event?
  final String? eventName;
  final String? eventGoal;
  final String? eventAddress;

  /// recipient information -------------
  final dynamic recipientStatus;
  // personal recipient
  final bool personalRecipientStatus;
  final String? personalRecipientName;
  final String? personalRecipientAddress;
  final String? personalRecipientKtpPhoto;
  final String? personalRecipientKtpNumber;
  final String? personalRecipientKtpName;
  final String? personalRecipientKtpBirthPlace;
  final DateTime? personalRecipientKtpBirthDate;
  final String? personalRecipientKtpGender;
  final String? personalRecipientKtpAddress;
  // foundation recipient
  final bool foundationRecipientStatus;
  final String? foundationRecipientName;
  final String? foundationRecipientResponsiblePerson;
  final String? foundationRecipientAddress;
  final String? foundationRecipientPermissionLetterPhoto;
  final String? foundationRecipientKtpPhoto;
  final String? foundationRecipientKtpNumber;
  final String? foundationRecipientKtpName;
  final String? foundationRecipientKtpBirthPlace;
  final DateTime? foundationRecipientKtpBirthDate;
  final String? foundationRecipientKtpGender;
  final String? foundationRecipientKtpAddress;
  // recipient additional
  final String? recipientFundNeed;
  final String? recipientDescriptionFundNeed;
  final String? recipientProofPhoto;
  final String? recipientRekeningNumber;
  final String? recipientBankBookPhoto;
  // recipient information -------------

  // other objects
  final User? user;
  final CampaignType? campaignType;
  final CampaignCategory? campaignCategory;
  final CampaignSubCategory? campaignSubCategory;
  final List<Donation> donation;

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
    required this.recipientStatus,
    required this.personalRecipientStatus,
    required this.personalRecipientName,
    required this.personalRecipientAddress,
    required this.personalRecipientKtpPhoto,
    required this.personalRecipientKtpNumber,
    required this.personalRecipientKtpName,
    required this.personalRecipientKtpBirthPlace,
    required this.personalRecipientKtpBirthDate,
    required this.personalRecipientKtpGender,
    required this.personalRecipientKtpAddress,
    required this.foundationRecipientStatus,
    required this.foundationRecipientName,
    required this.foundationRecipientResponsiblePerson,
    required this.foundationRecipientAddress,
    required this.foundationRecipientPermissionLetterPhoto,
    required this.foundationRecipientKtpPhoto,
    required this.foundationRecipientKtpNumber,
    required this.foundationRecipientKtpName,
    required this.foundationRecipientKtpBirthPlace,
    required this.foundationRecipientKtpBirthDate,
    required this.foundationRecipientKtpGender,
    required this.foundationRecipientKtpAddress,
    required this.recipientFundNeed,
    required this.recipientDescriptionFundNeed,
    required this.recipientProofPhoto,
    required this.recipientRekeningNumber,
    required this.recipientBankBookPhoto,
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
  bool get recipientBankVerified => recipientRekeningNumber != null && recipientBankBookPhoto != null;

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
        recipientStatus,
        personalRecipientStatus,
        personalRecipientName,
        personalRecipientAddress,
        personalRecipientKtpPhoto,
        personalRecipientKtpNumber,
        personalRecipientKtpName,
        personalRecipientKtpBirthPlace,
        personalRecipientKtpBirthDate,
        personalRecipientKtpGender,
        personalRecipientKtpAddress,
        foundationRecipientStatus,
        foundationRecipientName,
        foundationRecipientResponsiblePerson,
        foundationRecipientAddress,
        foundationRecipientPermissionLetterPhoto,
        foundationRecipientKtpPhoto,
        foundationRecipientKtpNumber,
        foundationRecipientKtpName,
        foundationRecipientKtpBirthPlace,
        foundationRecipientKtpBirthDate,
        foundationRecipientKtpGender,
        foundationRecipientKtpAddress,
        recipientFundNeed,
        recipientDescriptionFundNeed,
        recipientProofPhoto,
        recipientRekeningNumber,
        recipientBankBookPhoto,
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
