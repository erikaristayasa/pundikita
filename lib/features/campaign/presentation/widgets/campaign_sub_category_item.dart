import 'package:flutter/material.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';

class CampaignSubCategoryItem extends StatelessWidget {
  final CampaignSubCategory subCategory;
  const CampaignSubCategoryItem({Key? key, required this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: ListTile(
        onTap: () {},
        title: Text(subCategory.title ?? ''),
        subtitle: Text(subCategory.description ?? ''),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded),
      ),
    );
  }
}
