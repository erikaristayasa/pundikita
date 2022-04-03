import 'package:flutter/material.dart';

import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/presentation/widgets/default_image.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';

class CampaignItem extends StatelessWidget {
  const CampaignItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: Dimension.MEDIUM, vertical: Dimension.SMALL),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: RoundedContainer(
              clipBerhaviour: Clip.antiAlias,
              padding: const EdgeInsets.all(0.0),
              radius: 5.0,
              width: double.maxFinite,
              height: double.maxFinite,
              child: Image.network(
                getCampaignImageUrl('20220401143431-1648823671-BLE2uNRshhjBoDunrCygd2qu2vDGT2Z9txZmSavjeYUGsmqklB.jpg'),
                errorBuilder: (context, error, _) => const DefaultImage(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: ListView(
                padding: const EdgeInsets.only(left: Dimension.MEDIUM),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    'Title Campaing Title Campaing Title Campaing Title Campaing',
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  smallVerticalSpacing(),
                  Text(
                    'User Name User Name User Name User Name',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  smallVerticalSpacing(),
                  LinearProgressIndicator(
                    backgroundColor: AppColors.SECONDARY.withOpacity(0.3),
                    value: 0.5,
                  ),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(0.7),
                      1: FlexColumnWidth(0.3),
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          AppLocale.loc.collected,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          AppLocale.loc.dayLeft,
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          'getFormattedPrice(123456)',
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '3',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ])
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
