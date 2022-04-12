import 'package:flutter/material.dart';
import 'package:pundi_kita/core/domain/entities/campaign_entity.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';

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
            onTap: () {},
            title: AppLocale.loc.donateNow,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
