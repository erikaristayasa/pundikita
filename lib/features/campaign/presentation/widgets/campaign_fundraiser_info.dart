import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/enums.dart';
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

          // Fundraiser
          FundrasierField(campaign: campaign),
          mediumVerticalSpacing(),

          // Patient
          campaign.campaignService == CampaignService.donasi
              ? Column(
                  children: [
                    PatientField(campaign: campaign),
                    mediumVerticalSpacing(),
                  ],
                )
              : const SizedBox.shrink(),

          // Recipient
          RecipientField(campaign: campaign),
          mediumVerticalSpacing(),

          // Fund usage
          UsageField(campaign: campaign),
        ],
      ),
    );
  }
}

class FundrasierField extends StatelessWidget {
  final Campaign campaign;
  const FundrasierField({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = campaign.user;
    return RoundedContainer(
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
                    foregroundImage: (_user?.photo != null) ? NetworkImage(getUserImageUrl((_user?.photo)!)) : null,
                  ),
                ),
                mediumHorizontalSpacing(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.userId == null ? 'Pundikita' : _user?.name ?? '-',
                      style: context.textTheme().titleSmall,
                    ),
                    Text(
                      '${_user?.agencyStatus ?? ''}', //TODO: get status verification
                      style: context.textTheme().bodySmall,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PatientField extends StatelessWidget {
  final Campaign campaign;
  const PatientField({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
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
    );
  }
}

class RecipientField extends StatefulWidget {
  final Campaign campaign;
  const RecipientField({Key? key, required this.campaign}) : super(key: key);

  @override
  State<RecipientField> createState() => _RecipientFieldState();
}

class _RecipientFieldState extends State<RecipientField> {
  String _recipientName = '-';

  @override
  void initState() {
    super.initState();

    if (widget.campaign.personalRecipientStatus) {
      _recipientName = widget.campaign.personalRecipientName ?? '';
    } else if (widget.campaign.foundationRecipientStatus) {
      _recipientName = widget.campaign.foundationRecipientName ?? '';
    } else {
      _recipientName = widget.campaign.user?.name ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      radius: Dimension.MEDIUM,
      width: double.maxFinite,
      shadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocale.loc.fundRecipient,
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
                      _recipientName,
                      style: context.textTheme().titleSmall,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocale.loc.recipientRekeningVerified,
                          style: context.textTheme().bodySmall,
                        ),
                        smallHorizontalSpacing(),
                        ValidationIcon(isValidate: widget.campaign.recipientBankVerified),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UsageField extends StatelessWidget {
  final Campaign campaign;
  const UsageField({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
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
    );
  }
}
