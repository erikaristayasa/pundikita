import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';

class HomeCampaignType extends StatelessWidget {
  const HomeCampaignType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedContainer(
            color: AppColors.SECONDARY.withOpacity(0.15),
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: Dimension.SMALL),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.label_important_rounded,
                  color: AppColors.PRIMARY,
                ),
                smallHorizontalSpacing(),
                Text(
                  'Galang Dana Sekarang',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          mediumVerticalSpacing(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CampaignTypeItem(fileName: 'icon-galang-dana-medis.svg', title: 'type 1'),
              CampaignTypeItem(fileName: 'icon-galang-dana-nonmedis.svg', title: 'type 2'),
            ],
          ),
        ],
      ),
    );
  }
}

class CampaignTypeItem extends StatelessWidget {
  final String fileName;
  final String title;
  const CampaignTypeItem({Key? key, required this.fileName, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.network(
          getCampaignTypeImageUrl(fileName),
          fit: BoxFit.cover,
          height: 60,
          width: 60,
        ),
        mediumVerticalSpacing(),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
