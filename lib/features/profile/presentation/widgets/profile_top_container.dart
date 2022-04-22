import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';

class ProfileTopContainer extends StatelessWidget {
  const ProfileTopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      height: 110,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: CircleAvatar(
              backgroundColor: AppColors.SECONDARY.withOpacity(0.15),
            ),
          ),
          mediumHorizontalSpacing(),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UserName',
                  style: context.textTheme().headline6,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                RoundedButton(
                  width: 100.0,
                  height: 30.0,
                  outline: true,
                  onTap: () {},
                  title: AppLocale.loc.editProfile,
                  titleColor: AppColors.PRIMARY,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
