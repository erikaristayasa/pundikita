import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';

class HomeLabel extends StatelessWidget {
  final String title;
  const HomeLabel({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
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
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
