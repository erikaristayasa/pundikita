import 'package:flutter/material.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/utility/helper.dart';

class CampaignCategoryItem extends StatelessWidget {
  final CampaignCategory category;
  const CampaignCategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        getCampaignCategoryImageUrl(category.icon ?? ''),
        width: 40,
        fit: BoxFit.contain,
      ),
      title: Text(category.categoryName ?? ''),
      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
    );
  }
}
