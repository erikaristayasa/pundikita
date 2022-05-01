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
import '../../../campaign/presentation/pages/campaign_detail_page.dart';

class HomeCampaignItem extends StatelessWidget {
  final Campaign campaign;
  const HomeCampaignItem({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        path.CAMPAIGN_DETAIL,
        arguments: CampaignDetailPageRouteArguments(
          id: campaign.id,
          service: campaign.campaignService,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 3 / 4.5,
        child: RoundedContainer(
          clipBerhaviour: Clip.antiAlias,
          padding: null,
          radius: 5.0,
          shadow: true,
          // width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 5 / 3,
                child: Image.network(
                  getCampaignImageUrl(campaign.photo ?? ''),
                  errorBuilder: (context, error, _) => const DefaultImage(),
                  fit: BoxFit.cover,
                ),
              ),
              ListView(
                padding: const EdgeInsets.all(Dimension.MEDIUM),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    campaign.title ?? '',
                    style: context.textTheme().titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  mediumVerticalSpacing(),
                  Text(
                    campaign.user?.name ?? "",
                    style: context.textTheme().bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  mediumVerticalSpacing(),
                  LinearProgressIndicator(
                    backgroundColor: AppColors.SECONDARY.withOpacity(0.3),
                    value: campaign.progress,
                  ),
                  mediumVerticalSpacing(),
                  Text(
                    AppLocale.loc.collected,
                    style: context.textTheme().bodySmall,
                  ),
                  smallVerticalSpacing(),
                  Text(
                    getFormattedPrice(campaign.amountOfCollectedFunds.toInt()),
                    style: context.textTheme().titleSmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
