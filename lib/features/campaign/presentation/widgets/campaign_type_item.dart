import 'package:flutter/material.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/utility/helper.dart';
import 'package:flutter_svg/svg.dart';

class CampaignTypeItem extends StatelessWidget {
  final CampaignType type;
  const CampaignTypeItem({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      shadow: true,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListTile(
              leading: SvgPicture.network(
                getCampaignTypeImageUrl(type.icon),
                width: 80.0,
                fit: BoxFit.contain,
              ),
              title: Text(type.title ?? ''),
              subtitle: Text(
                type.description ?? '',
                maxLines: 2,
              ),
            ),
          ),
          mediumVerticalSpacing(),
          RoundedButton(
            radius: 22.0,
            onTap: () {},
            title: "Pilih",
          ),
        ],
      ),
    );
  }
}
