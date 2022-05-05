import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';

class BottomNavigationBarActions extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const BottomNavigationBarActions({Key? key, this.onPrevious, this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Row(
        children: [
          onPrevious != null
              ? Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: Dimension.SMALL),
                    child: RoundedButton(
                      title: AppLocale.loc.previous,
                      titleColor: AppColors.PRIMARY,
                      outline: true,
                      onTap: onPrevious,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            flex: 3,
            child: RoundedButton(
              title: AppLocale.loc.next,
              onTap: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
