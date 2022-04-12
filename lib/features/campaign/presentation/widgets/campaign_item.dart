import 'package:flutter/material.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/widgets/default_image.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../pages/campaign_detail_page.dart';

class CampaignItem extends StatelessWidget {
  final Campaign campaign;
  const CampaignItem({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, path.CAMPAIGN_DETAIL, arguments: CampaignDetailPageRouteArguments(id: 1, service: campaign.campaignService)),
      child: Container(
        height: 160,
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
                  getCampaignImageUrl(campaign.photo ?? ''),
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
                    RoundedContainer(
                      color: AppColors.SECONDARY.withOpacity(0.15),
                      child: Text(
                        campaign.title ?? '',
                        style: context.textTheme().titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    smallVerticalSpacing(),
                    Text(
                      campaign.user?.name ?? '',
                      style: context.textTheme().bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    smallVerticalSpacing(),
                    LinearProgressIndicator(
                      backgroundColor: AppColors.SECONDARY.withOpacity(0.3),
                      value: campaign.progress,
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
                            style: context.textTheme().bodySmall,
                          ),
                          Text(
                            AppLocale.loc.dayLeft,
                            textAlign: TextAlign.end,
                            style: context.textTheme().bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]),
                        TableRow(children: [
                          Text(
                            getFormattedPrice(campaign.amountOfCollectedFunds.toInt()),
                            style: context.textTheme().titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            campaign.leftDate.toString(),
                            textAlign: TextAlign.end,
                            style: context.textTheme().titleSmall,
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
      ),
    );
  }
}
