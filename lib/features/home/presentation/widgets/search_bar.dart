import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/assets.dart';

import '../../../../core/routes/path.dart' as path;
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
          AspectRatio(
            aspectRatio: 1 / 1,
            child: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(1.5),
                child: Image.asset(Assets.LOGO),
              ),
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
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, path.SEARCH),
                      child: Text(
                        AppLocale.loc.search,
                        style: context.textTheme().bodySmall!.withColor(Colors.white),
                      ),
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
