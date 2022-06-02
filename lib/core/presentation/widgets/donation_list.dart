import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/campaign_entity.dart';
import '../../domain/entities/donation_entity.dart';
import '../../static/colors.dart';
import '../../static/dimens.dart';
import '../../static/enums.dart';
import '../../static/extensions.dart';
import '../../utility/app_locale.dart';
import '../../utility/helper.dart';
import '../cubits/donation_filter_cubit.dart';
import '../cubits/donation_items_cubit.dart';
import 'aamin_button.dart';
import 'custom_label.dart';
import 'rounded_container.dart';

class DonationList extends StatefulWidget {
  final String labelText;
  final List<Donation> donations;
  final Campaign? globalCampaign;
  const DonationList({
    Key? key,
    required this.donations,
    required this.labelText,
    this.globalCampaign,
  }) : super(key: key);

  @override
  State<DonationList> createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  late DonationItemsCubit donationItemsCubit;
  @override
  void initState() {
    super.initState();
    donationItemsCubit = DonationItemsCubit(donation: widget.donations);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomLabel(title: widget.labelText),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Filter(
                  onCallback: (filter) {
                    donationItemsCubit.filter(filter);
                  },
                ),
              ),
            ],
          ),
          BlocBuilder<DonationItemsCubit, List<Donation>>(
            bloc: donationItemsCubit,
            builder: (context, state) {
              if (state.isEmpty) {
                return const SizedBox.shrink();
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.length,
                  itemBuilder: (context, index) => Prayer(
                    donation: state.elementAt(index),
                    campaign: widget.globalCampaign ?? state.elementAt(index).campaign,
                  ),
                  separatorBuilder: (context, index) => smallVerticalSpacing(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class Prayer extends StatelessWidget {
  final Donation donation;
  final Campaign? campaign;
  const Prayer({Key? key, required this.donation, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _profilePhoto = donation.user?.photo ?? '';
    final _name = donation.user?.name ?? '';
    final _campaignTitle = campaign?.title ?? '';
    final _likeCount = donation.likes.length;
    return RoundedContainer(
      color: AppColors.BG_Grey,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(getUserImageUrl(_profilePhoto)),
                  backgroundColor: AppColors.PRIMARY.withOpacity(0.5),
                ),
                smallHorizontalSpacing(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name,
                        style: context.textTheme().titleSmall,
                      ),
                      Text(
                        _campaignTitle,
                        style: context.textTheme().caption?.withColor(AppColors.PRIMARY),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Text.rich(
                      //   TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: AppLocale.loc.donate + ': ',
                      //         style: context.textTheme().bodySmall,
                      //       ),
                      //       TextSpan(
                      //         text: getFormattedPrice(donation.amountOfFunds.toInt()),
                      //         style: context.textTheme().titleSmall,
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
                Text(
                  '•' + donation.createdAt.toText(format: 'dd/MM/yyyy'),
                  style: context.textTheme().labelSmall?.withColor(AppColors.PRIMARY),
                )
              ],
            ),
          ),
          mediumVerticalSpacing(),
          Text.rich(
            TextSpan(children: [
              TextSpan(text: '$_likeCount ', style: context.textTheme().titleSmall?.withColor(AppColors.PRIMARY)), //TODO: missing likes count
              TextSpan(text: AppLocale.loc.prayForThis, style: context.textTheme().bodySmall?.withColor(AppColors.PRIMARY)),
            ]),
          ),
          Text(
            donation.pray ?? '',
            style: context.textTheme().bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          mediumVerticalSpacing(),
          const Divider(thickness: 1.5),
          Center(
            child: AaminButton(
              donationId: donation.id,
              likeStatus: donation.likeStatus,
            ),
          )
        ],
      ),
    );
  }
}

class Filter extends StatefulWidget {
  final Function(DonationFilter filter) onCallback;
  const Filter({Key? key, required this.onCallback}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final DonationFilterCubit cubit = DonationFilterCubit();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<DonationFilterCubit, DonationFilter>(
        bloc: cubit,
        builder: (context, state) => DropdownButton<DonationFilter>(
          value: cubit.state,
          icon: const Icon(Icons.arrow_drop_down_rounded),
          onChanged: (filter) {
            cubit.setFiler = filter!;
            widget.onCallback(filter);
          },
          items: DonationFilter.values.map<DropdownMenuItem<DonationFilter>>((DonationFilter value) {
            return DropdownMenuItem<DonationFilter>(
              value: value,
              child: Text(
                value.name.toCapitalized(),
                style: context.textTheme().labelMedium,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
