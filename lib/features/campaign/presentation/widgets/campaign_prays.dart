import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/presentation/widgets/rounded_container.dart';
import 'package:pundi_kita/core/static/colors.dart';
import 'package:pundi_kita/core/utility/app_locale.dart';

import '../../../../core/presentation/widgets/custom_label.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/helper.dart';
import '../cubit/campaign_pray_filter_cubit.dart';

class CampaignPrays extends StatelessWidget {
  const CampaignPrays({Key? key}) : super(key: key);

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
              CustomLabel(title: AppLocale.loc.praysGoodPeople),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Filter(
                  onCallback: (filter) {},
                ),
              ),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) => const Prayer(),
            separatorBuilder: (context, index) => smallVerticalSpacing(),
          )
        ],
      ),
    );
  }
}

class Prayer extends StatelessWidget {
  const Prayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: AppColors.BG_Grey,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.PRIMARY.withOpacity(0.5),
                ),
                smallHorizontalSpacing(),
                Expanded(
                  child: Text(
                    'User name',
                    style: context.textTheme().titleSmall,
                  ),
                ),
                Text(
                  '2022-04-01',
                  style: context.textTheme().labelSmall,
                )
              ],
            ),
          ),
          mediumVerticalSpacing(),
          Text(
            "Semoga lekas sehat. Aamiin.",
            style: context.textTheme().bodyMedium,
          ),
          mediumVerticalSpacing(),
          Text.rich(
            TextSpan(children: [
              TextSpan(text: '5 ', style: context.textTheme().titleSmall),
              TextSpan(text: AppLocale.loc.prayForThis, style: context.textTheme().bodySmall),
            ]),
          ),
          const Divider(thickness: 1.5),
          Center(
            child: TextButton.icon(onPressed: () {}, icon: const Icon(Icons.favorite_border_rounded), label: Text(AppLocale.loc.aamiin)),
          )
        ],
      ),
    );
  }
}

class Filter extends StatefulWidget {
  final Function(PrayFilter filter) onCallback;
  const Filter({Key? key, required this.onCallback}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final CampaignPrayFilterCubit cubit = CampaignPrayFilterCubit();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<CampaignPrayFilterCubit, PrayFilter>(
        bloc: cubit,
        builder: (context, state) => DropdownButton<PrayFilter>(
          value: cubit.state,
          icon: const Icon(Icons.arrow_drop_down_rounded),
          onChanged: (filter) => cubit.setFiler = filter!,
          items: PrayFilter.values.map<DropdownMenuItem<PrayFilter>>((PrayFilter value) {
            return DropdownMenuItem<PrayFilter>(
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
