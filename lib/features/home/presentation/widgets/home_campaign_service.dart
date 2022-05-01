import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/custom_label.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../campaign/presentation/pages/campaign_all_page.dart';

class HomeCampaignService extends StatelessWidget {
  const HomeCampaignService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(title: AppLocale.loc.fundraiseNow),
          mediumVerticalSpacing(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: CampaignServiceItem(
                    onTap: () => Navigator.pushNamed(context, path.CAMPAIGN_ALL, arguments: CampaignAllPageRouteArguments(service: CampaignService.donasi)),
                    asset: Assets.HOME_DONATION,
                    title: AppLocale.loc.donation),
              ),
              Expanded(
                flex: 1,
                child: CampaignServiceItem(
                    onTap: () => Navigator.pushNamed(context, path.CAMPAIGN_ALL, arguments: CampaignAllPageRouteArguments(service: CampaignService.zakat)),
                    asset: Assets.HOME_ZAKAT,
                    title: AppLocale.loc.zakat),
              ),
              Expanded(
                flex: 1,
                child: CampaignServiceItem(
                  onTap: () => Navigator.pushNamed(context, path.CAMPAIGN_CREATE),
                  asset: Assets.HOME_FUNDRASING,
                  title: AppLocale.loc.raiseFunds,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CampaignServiceItem extends StatelessWidget {
  final String asset;
  final String title;
  final VoidCallback onTap;
  const CampaignServiceItem({Key? key, required this.asset, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          // SvgPicture.network(
          //   getCampaignTypeImageUrl(fileName),
          //   fit: BoxFit.cover,
          //   height: 60,
          //   width: 60,
          // ),
          Image.asset(
            asset,
            fit: BoxFit.cover,
            height: 60,
            width: 60,
          ),
          mediumVerticalSpacing(),
          Text(
            title,
            style: context.textTheme().bodyMedium,
          ),
        ],
      ),
    );
  }
}
