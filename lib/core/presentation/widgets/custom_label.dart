import 'package:flutter/material.dart';
import '../../static/extensions.dart';

import '../../static/colors.dart';
import '../../static/dimens.dart';
import '../../utility/helper.dart';
import 'rounded_container.dart';

class CustomLabel extends StatelessWidget {
  final String title;
  const CustomLabel({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: Dimension.MEDIUM,
      color: AppColors.SECONDARY.withOpacity(0.15),
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: Dimension.MEDIUM, left: Dimension.SMALL),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.label_important_rounded,
            color: AppColors.PRIMARY,
          ),
          smallHorizontalSpacing(),
          Text(
            title,
            style: context.textTheme().titleSmall,
          ),
        ],
      ),
    );
  }
}
