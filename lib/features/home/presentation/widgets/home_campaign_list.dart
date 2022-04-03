import 'package:flutter/material.dart';

import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import 'home_campaign_item.dart';
import 'home_label.dart';

class HomeCampaignList extends StatelessWidget {
  const HomeCampaignList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeLabel(title: AppLocale.loc.donationOptions),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, path.CAMPAIGN_ALL),
                child: Text(
                  AppLocale.loc.seeMore,
                  style: Theme.of(context).textTheme.bodySmall!.withColor(AppColors.SECONDARY),
                ),
              )
            ],
          ),
          mediumVerticalSpacing(),
          SizedBox(
            height: 350,
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: Dimension.MEDIUM),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => const HomeCampaignItem(),
              separatorBuilder: (context, index) => mediumHorizontalSpacing(),
            ),
          )
        ],
      ),
    );
  }
}
