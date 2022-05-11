import 'package:flutter/material.dart';

import 'rounded_container.dart';
import '../../static/assets.dart';
import '../../static/colors.dart';
import '../../static/dimens.dart';
import '../../static/extensions.dart';
import '../../utility/helper.dart';

class NominalItem extends StatelessWidget {
  final Function(int nominal) onSelect;
  final int nominal;
  final bool selected;
  const NominalItem({Key? key, required this.onSelect, required this.nominal, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(0.0),
      color: Colors.white,
      child: ListTile(
        onTap: () => onSelect(nominal),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimension.SMALL),
          child: Image.asset(Assets.COIN),
        ),
        title: Text(
          getFormattedPrice(nominal),
          style: context.textTheme().titleSmall,
        ),
        trailing: selected
            ? const Icon(
                Icons.check_circle,
                color: AppColors.PRIMARY,
              )
            : null,
      ),
    );
  }
}
