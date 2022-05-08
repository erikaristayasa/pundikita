import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pundi_kita/core/static/assets.dart';
import 'package:pundi_kita/core/static/enums.dart';

extension AdditionalStyle on TextStyle {
  TextStyle withColor(Color color) {
    return merge(TextStyle(color: color));
  }

  TextStyle withFontSize(double size) {
    return merge(TextStyle(fontSize: size));
  }
}

extension DateFormatting on DateTime? {
  String toText({String? format}) {
    if (this == null) {
      return '';
    }
    return DateFormat(format ?? "yyyy-MM-dd").format(this!);
  }
}

extension StringFormatting on String {
  DateTime? toDate({String? format}) {
    try {
      final date = DateFormat(format ?? "yyyy-MM-dd").parse(this);
      return date;
    } catch (e) {
      return null;
    }
  }

  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

extension ThemeOfContext on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;
}

extension DynamicHeader on Dio {
  Dio withToken() {
    return this..options.headers.addAll({'token': true});
  }
}

extension DonationPaymentStatus on num {
  DonationPayStatus donationPayStatus() {
    if (this == 0) {
      return DonationPayStatus.pending;
    } else if (this == 1) {
      return DonationPayStatus.paid;
    } else {
      return DonationPayStatus.failed;
    }
  }
}

extension PaymentInfo on PaymentChannel {
  String get icon {
    switch (this) {
      case PaymentChannel.bag:
        return Assets.BAG;
      case PaymentChannel.bca:
        return Assets.BCA;
      case PaymentChannel.bni:
        return Assets.BNI;
      case PaymentChannel.cimb:
        return Assets.CIMB;
      case PaymentChannel.mandiri:
        return Assets.MANDIRI;
      case PaymentChannel.bmi:
        return Assets.BMI;
      case PaymentChannel.bri:
        return Assets.BRI;
      case PaymentChannel.bsi:
        return Assets.BSI;
      case PaymentChannel.permata:
        return Assets.PERMATA;
      case PaymentChannel.qris:
        return Assets.QRIS;
      case PaymentChannel.saldo:
        return Assets.WALLET;
    }
  }

  String get title {
    switch (this) {
      case PaymentChannel.bag:
        return 'Bank Artha Graha';
      case PaymentChannel.bca:
        return 'Bank Central Asia';
      case PaymentChannel.bni:
        return 'Bank Negara Indonesia';
      case PaymentChannel.cimb:
        return 'Bank CIMB Niaga';
      case PaymentChannel.mandiri:
        return 'Bank Mandiri';
      case PaymentChannel.bmi:
        return 'Bank Muamalat Indonesia';
      case PaymentChannel.bri:
        return 'Bank Rakyat Indonesia';
      case PaymentChannel.bsi:
        return 'Bank Syariah Indonesia';
      case PaymentChannel.permata:
        return 'Bank Permata';
      case PaymentChannel.qris:
        return 'QRIS';
      case PaymentChannel.saldo:
        return 'Dompet';
    }
  }

  BoxFit get fit {
    switch (this) {
      case PaymentChannel.bmi:
      case PaymentChannel.bri:
        return BoxFit.fitHeight;
      case PaymentChannel.bag:
      case PaymentChannel.bca:
      case PaymentChannel.bni:
      case PaymentChannel.cimb:
      case PaymentChannel.mandiri:
      case PaymentChannel.bsi:
      case PaymentChannel.permata:
      case PaymentChannel.qris:
        return BoxFit.fitWidth;
      case PaymentChannel.saldo:
        return BoxFit.contain;
    }
  }

  double get iconWidth {
    if (this == PaymentChannel.saldo) {
      return 40;
    }
    return 60;
  }
}

extension TransForm on DonatureType {
  int toInteger() {
    switch (this) {
      case DonatureType.personal:
        return 1;
      case DonatureType.foundation:
        return 2;
    }
  }

  String getString() {
    switch (this) {
      case DonatureType.personal:
        return 'Personal';
      case DonatureType.foundation:
        return 'Yayasan';
    }
  }
}

extension RecipientTransForm on RecipientType {
  String getString() {
    switch (this) {
      case RecipientType.personal:
        return 'Personal';
      case RecipientType.foundation:
        return 'Yayasan';
    }
  }

  int toInteger() {
    switch (this) {
      case RecipientType.personal:
        return 1;
      case RecipientType.foundation:
        return 2;
    }
  }
}

extension GenderTransform on Gender {
  String getString() {
    switch (this) {
      case Gender.male:
        return 'Laki-laki';
      case Gender.female:
        return 'Perempuan';
    }
  }
}

extension CampaignStepTransform on CampaignStep {
  String getString() {
    switch (this) {
      case CampaignStep.prepare:
        return 'Persiapan';
      case CampaignStep.patient:
        return 'Pasien';
      case CampaignStep.personalData:
        return 'Data Pribadi';
      case CampaignStep.fundTarget:
        return 'Target Donasi';
      case CampaignStep.recipient:
        return 'Penerima Dana';
      case CampaignStep.advertisement:
        return 'Iklan';
      case CampaignStep.event:
        return 'Acara';
    }
  }
}

extension WhoSickTransform on WhoSick {
  String getString() {
    switch (this) {
      case WhoSick.me:
        return 'Saya Sendiri';
      case WhoSick.myFamily:
        return 'Keluarga yang satu KK dengan saya';
      case WhoSick.myOtherFamily:
        return 'Keluarga inti (ayah/ibu/kakak/adik/anak) yang sudah pisah KK dengan saya';
      case WhoSick.others:
        return 'Selain pilihan di atas';
    }
  }
}

extension HospitalityStatusTransForm on HospitalityStatus {
  String getString() {
    switch (this) {
      case HospitalityStatus.inpatient:
        return 'Rawat Inap';
      case HospitalityStatus.selfCare:
        return 'Rawat Mandiri';
    }
  }

  int toInteger() {
    switch (this) {
      case HospitalityStatus.inpatient:
        return 1;
      case HospitalityStatus.selfCare:
        return 2;
    }
  }
}
