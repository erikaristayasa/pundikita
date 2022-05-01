import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../campaign/presentation/pages/campaign_all_page.dart';

class MyDonationEmpty extends StatelessWidget {
  const MyDonationEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimension.LARGE),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              Assets.LOTTIE_NO_DATA,
              width: 150.0,
            ),
            mediumVerticalSpacing(),
            RoundedButton(
              onTap: () => Navigator.pushNamed(
                context,
                path.CAMPAIGN_ALL,
                arguments: CampaignAllPageRouteArguments(service: CampaignService.donasi),
              ),
              title: AppLocale.loc.donateNow,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
