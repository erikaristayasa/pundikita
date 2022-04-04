import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/custom_label.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/presentation/widgets/validation_icon.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';

class CampaignFundraiserInfo extends StatelessWidget {
  const CampaignFundraiserInfo({Key? key}) : super(key: key);

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
                      const AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                        ),
                      ),
                      mediumHorizontalSpacing(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User name',
                            style: context.textTheme().titleSmall,
                          ),
                          Text(
                            'subtitle',
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
                            'User name',
                            style: context.textTheme().titleSmall,
                          ),
                          Row(
                            children: [
                              Text(
                                'subtitle',
                                style: context.textTheme().bodySmall,
                              ),
                              smallHorizontalSpacing(),
                              const ValidationIcon(isValidate: false),
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
                            'Sickness',
                            style: context.textTheme().titleSmall,
                          ),
                          Row(
                            children: [
                              Text(
                                'subtitle',
                                style: context.textTheme().bodySmall,
                              ),
                              smallHorizontalSpacing(),
                              const ValidationIcon(isValidate: true)
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
        ],
      ),
    );
  }
}
