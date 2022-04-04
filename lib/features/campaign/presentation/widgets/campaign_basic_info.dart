import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';

class CampaignBasicInfo extends StatelessWidget {
  const CampaignBasicInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Campaign Title',
            style: context.textTheme().titleLarge,
          ),
          mediumVerticalSpacing(),
          Row(
            children: [
              Text(
                getFormattedPrice(150000),
                style: context.textTheme().titleMedium!.withColor(AppColors.PRIMARY),
              ),
              smallHorizontalSpacing(),
              Text(
                AppLocale.loc.collectedFrom(getFormattedPrice(300000)),
                style: context.textTheme().bodySmall,
              )
            ],
          ),
          smallVerticalSpacing(),
          LinearProgressIndicator(
            backgroundColor: AppColors.SECONDARY.withOpacity(0.3),
            value: 0.5,
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
