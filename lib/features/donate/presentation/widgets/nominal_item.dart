import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/helper.dart';

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
