import 'package:flutter/material.dart';

import '../../static/colors.dart';
import '../../static/dimens.dart';
import '../../utility/app_locale.dart';
import '../../utility/helper.dart';
import 'default_image.dart';
import 'rounded_container.dart';

class CampaignItem extends StatelessWidget {
  const CampaignItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4.5,
      child: RoundedContainer(
        clipBerhaviour: Clip.antiAlias,
        padding: null,
        radius: 5.0,
        shadow: true,
        // width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 5 / 3,
              child: Image.network(
                getCampaignImageUrl('20220401143431-1648823671-BLE2uNRshhjBoDunrCygd2qu2vDGT2Z9txZmSavjeYUGsmqklB.jpg'),
                errorBuilder: (context, error, _) => const DefaultImage(),
                fit: BoxFit.cover,
              ),
            ),
            ListView(
              padding: const EdgeInsets.all(Dimension.MEDIUM),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Text(
                  'Title Campaing Title Campaing Title Campaing Title Campaing',
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                mediumVerticalSpacing(),
                Text(
                  'User Name User Name User Name User Name',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                mediumVerticalSpacing(),
                LinearProgressIndicator(
                  backgroundColor: AppColors.SECONDARY.withOpacity(0.3),
                  value: 0.5,
                ),
                mediumVerticalSpacing(),
                Text(
                  AppLocale.loc.collected,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                smallVerticalSpacing(),
                Text(
                  getFormattedPrice(123456),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
