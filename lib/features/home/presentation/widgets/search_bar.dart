import 'package:flutter/material.dart';

import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';

class SearchBar extends StatelessWidget with PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.PRIMARY,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: Dimension.MEDIUM, vertical: Dimension.SMALL),
      child: Row(
        children: [
          // TODO: change with app logo
          const AspectRatio(
            aspectRatio: 1 / 1,
            child: CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
          smallHorizontalSpacing(),
          Expanded(
            child: Container(
              height: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: Dimension.MEDIUM),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((kToolbarHeight - Dimension.MEDIUM) / 2),
                color: Colors.white.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      AppLocale.loc.search,
                      style: Theme.of(context).textTheme.bodySmall!.withColor(Colors.white),
                    ),
                  ),
                  const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
