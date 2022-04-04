import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/assets.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/utility/app_locale.dart';
import '../widgets/campaign_item.dart';

class CampaignAllPage extends StatelessWidget {
  const CampaignAllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppLocale.loc.campaignList,
        canBack: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.PRIMARY.withOpacity(0.2)),
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      Assets.FILTER,
                      width: 18.0,
                    ),
                    label: Text(AppLocale.loc.category),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      Assets.SORT,
                      width: 18.0,
                    ),
                    label: Text(AppLocale.loc.sort),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => const CampaignItem(),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
