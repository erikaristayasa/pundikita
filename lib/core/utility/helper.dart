import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../static/config.dart';
import '../static/dimens.dart';

AppLocalizations getLocalizationString(BuildContext context) {
  return AppLocalizations.of(context)!;
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

String getCampaignImageUrl(String fileName) => Config.BASE_URL + Config.PATH_PHOTO_CAMPAIGN + fileName;
String getCampaignTypeImageUrl(String fileName) => Config.BASE_URL + Config.PATH_PHOTO_CAMPAIGN_TYPE + fileName;
String getCampaignCategoryImageUrl(String fileName) => Config.BASE_URL + Config.PATH_PHOTO_CAMPAIGN_CATEGORY + fileName;
