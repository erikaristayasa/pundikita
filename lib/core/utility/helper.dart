import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../static/config.dart';
import '../static/dimens.dart';

AppLocalizations getLocalizationString(BuildContext context) {
  return AppLocalizations.of(context)!;
}

String getFormattedPrice(int price) {
  final formatter = NumberFormat.currency(locale: "id_ID", symbol: 'Rp');
  formatter.maximumFractionDigits = 0;
  return formatter.format(price);
}

logMe(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

Widget smallVerticalSpacing() => const SizedBox(height: Dimension.SMALL);
Widget mediumVerticalSpacing() => const SizedBox(height: Dimension.MEDIUM);
Widget largeVerticalSpacing() => const SizedBox(height: Dimension.LARGE);

Widget smallHorizontalSpacing() => const SizedBox(width: Dimension.SMALL);
Widget mediumHorizontalSpacing() => const SizedBox(width: Dimension.MEDIUM);
Widget largeHorizontalSpacing() => const SizedBox(width: Dimension.LARGE);

String getUserImageUrl(String fileName) => Config.BASE_URL + Config.PATH_PHOTO_USER + fileName;
String getCampaignImageUrl(String fileName) => Config.BASE_URL + Config.PATH_PHOTO_CAMPAIGN + fileName;
String getCampaignTypeImageUrl(String fileName) => Config.BASE_URL + Config.PATH_PHOTO_CAMPAIGN_TYPE + fileName;
String getCampaignCategoryImageUrl(String fileName) => Config.BASE_URL + Config.PATH_PHOTO_CAMPAIGN_CATEGORY + fileName;
String getBannerImageUrl(String fileName) => Config.BASE_URL + Config.PATH_PHOTO_BANNER + fileName;

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

OutlineInputBorder get inputFieldBorder => const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(color: Colors.white),
    );
