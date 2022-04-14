import 'package:flutter/material.dart';
import 'package:pundi_kita/features/campaign/presentation/pages/fund_usage_detail_page.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/widgets/custom_label.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/presentation/widgets/validation_icon.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';

class CampaignFundraiserInfo extends StatelessWidget {
  final Campaign campaign;
  const CampaignFundraiserInfo({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(title: AppLocale.loc.fundraiserInfo),
          mediumVerticalSpacing(),

          // Fundraiser info
          RoundedContainer(
            padding: const EdgeInsets.all(Dimension.MEDIUM),
            radius: Dimension.MEDIUM,
            width: double.maxFinite,
            shadow: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocale.loc.fundraiser,
                  style: context.textTheme().titleSmall,
                ),
                smallVerticalSpacing(),
                SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CircleAvatar(
                          backgroundColor: AppColors.SECONDARY.withOpacity(0.15),
                          foregroundImage: NetworkImage(getUserImageUrl(campaign.user?.photo ?? '')),
                        ),
                      ),
                      mediumHorizontalSpacing(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            campaign.user?.name ?? '-',
                            style: context.textTheme().titleSmall,
                          ),
                          Text(
                            '${campaign.user?.agencyStatus ?? ''}', //TODO: get status verification
                            style: context.textTheme().bodySmall,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          mediumVerticalSpacing(),

          // Patient
          RoundedContainer(
            padding: const EdgeInsets.all(Dimension.MEDIUM),
            radius: Dimension.MEDIUM,
            width: double.maxFinite,
            shadow: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocale.loc.patient,
                  style: context.textTheme().titleSmall,
                ),
                smallVerticalSpacing(),
                SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CircleAvatar(
                          child: Image.asset(
                            Assets.PATIENT,
                            width: 24,
                          ),
                          backgroundColor: AppColors.SECONDARY.withOpacity(0.15),
                        ),
                      ),
                      mediumHorizontalSpacing(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            campaign.patientName ?? '-',
                            style: context.textTheme().titleSmall,
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocale.loc.patientVerified,
                                style: context.textTheme().bodySmall,
                              ),
                              smallHorizontalSpacing(),
                              ValidationIcon(isValidate: campaign.patientVerified),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                smallVerticalSpacing(),
                SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CircleAvatar(
                          child: Image.asset(
                            Assets.MEDICINE_BOX,
                            width: 24,
                          ),
                          backgroundColor: AppColors.SECONDARY.withOpacity(0.15),
                        ),
                      ),
                      mediumHorizontalSpacing(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            campaign.patientSickness ?? '-',
                            style: context.textTheme().titleSmall,
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocale.loc.patientSicknessVerified,
                                style: context.textTheme().bodySmall,
                              ),
                              smallHorizontalSpacing(),
                              ValidationIcon(isValidate: campaign.patientSicknessVerified)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          mediumVerticalSpacing(),

          // Dana Receiver
          RoundedContainer(
            padding: const EdgeInsets.all(Dimension.MEDIUM),
            radius: Dimension.MEDIUM,
            width: double.maxFinite,
            shadow: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocale.loc.fundraiser,
                  style: context.textTheme().titleSmall,
                ),
                smallVerticalSpacing(),
                SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CircleAvatar(
                          backgroundColor: AppColors.SECONDARY.withOpacity(0.15),
                          child: Image.asset(
                            Assets.FUND_RECIPIENT,
                            width: 24,
                          ),
                        ),
                      ),
                      mediumHorizontalSpacing(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            campaign.user?.name ?? '-',
                            style: context.textTheme().titleSmall,
                          ),
                          Text(
                            '${campaign.user?.agencyStatus ?? ''}', //TODO: get status verification
                            style: context.textTheme().bodySmall,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          mediumVerticalSpacing(),
          // Fund usage
          RoundedContainer(
            padding: const EdgeInsets.symmetric(horizontal: Dimension.MEDIUM),
            width: double.maxFinite,
            color: Colors.grey[200]!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocale.loc.fundUsageDetail,
                  style: context.textTheme().bodySmall,
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    path.FUND_USAGE_DETAIL,
                    arguments: FundUsageDetailUsageRouteArguments(
                      usageDetail: campaign.detailOfUseOfFunds ?? '',
                    ),
                  ),
                  child: Text(
                    AppLocale.loc.see,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
