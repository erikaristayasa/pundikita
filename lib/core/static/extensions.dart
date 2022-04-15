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
  String toText() {
    if (this == null) {
      return '';
    }
    return DateFormat("yyyy-MM-dd").format(this!);
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
