import 'package:flutter/material.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../donate/presentation/pages/donate_nominal_list_page.dart';

class CampaignBasicInfo extends StatelessWidget {
  final Campaign campaign;
  const CampaignBasicInfo({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            campaign.title ?? '',
            style: context.textTheme().titleLarge,
          ),
          mediumVerticalSpacing(),
          Row(
            children: [
              Text(
                getFormattedPrice(campaign.amountOfCollectedFunds.toInt()),
                style: context.textTheme().titleMedium!.withColor(AppColors.PRIMARY),
              ),
              smallHorizontalSpacing(),
              Text(
                AppLocale.loc.collectedFrom(getFormattedPrice(campaign.amountOfFunds.toInt())),
                style: context.textTheme().bodySmall,
              )
            ],
          ),
          smallVerticalSpacing(),
          LinearProgressIndicator(
            backgroundColor: AppColors.SECONDARY.withOpacity(0.3),
            value: campaign.progress,
          ),
          mediumVerticalSpacing(),
          RoundedButton(
            radius: 22,
            onTap: () => Navigator.pushNamed(
              context,
              path.DONATION_NOMINAL_LIST,
              arguments: DonateNominalListPageRouteArguments(campaignId: campaign.id),
            ),
            title: campaign.campaignService == CampaignService.donasi ? AppLocale.loc.donateNow : AppLocale.loc.zakatNow,
            color: campaign.campaignService == CampaignService.donasi ? Colors.red : Colors.blue,
          )
        ],
      ),
    );
  }
}
