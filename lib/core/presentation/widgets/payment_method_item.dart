import 'package:flutter/material.dart';

import '../../static/colors.dart';
import '../../static/dimens.dart';
import '../../static/enums.dart';
import '../../static/extensions.dart';

class PaymentMethodItem extends StatelessWidget {
  final String? subtitle;
  final PaymentMethod method;
  final PaymentChannel channel;
  final bool selected;
  final bool dense;
  final Function(PaymentMethod method, PaymentChannel channel) onSelect;
  const PaymentMethodItem({
    Key? key,
    required this.onSelect,
    required this.method,
    required this.channel,
    this.selected = false,
    this.subtitle,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onSelect(method, channel);
        Navigator.pop(context);
      },
      dense: dense,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimension.SMALL),
        child: Image.asset(
          channel.icon,
          fit: channel.fit,
          width: channel.iconWidth,
        ),
      ),
      title: Text(
        channel.title,
        style: context.textTheme().titleSmall,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.textTheme().caption,
            )
          : null,
      trailing: selected
          ? const Icon(
              Icons.check_circle,
              color: AppColors.PRIMARY,
            )
          : null,
    );
  }
}
