import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pundi_kita/core/static/assets.dart';
import '../../../../core/static/extensions.dart';

import '../../../../core/presentation/widgets/custom_label.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';

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
              Expanded(flex: 1, child: CampaignServiceItem(asset: Assets.HOME_DONATION, title: AppLocale.loc.donation)),
              Expanded(flex: 1, child: CampaignServiceItem(asset: Assets.HOME_ZAKAT, title: AppLocale.loc.zakat)),
              Expanded(flex: 1, child: CampaignServiceItem(asset: Assets.HOME_FUNDRASING, title: AppLocale.loc.raiseFunds)),
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
  const CampaignServiceItem({Key? key, required this.asset, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
