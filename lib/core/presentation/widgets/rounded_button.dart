import 'package:flutter/material.dart';

import '../../static/colors.dart';
import '../../static/extensions.dart';

class RoundedButton extends StatelessWidget {
  final bool outline;
  final bool enable;
  final double radius;
  final double height;
  final double width;
  final Color color;
  final dynamic title;
  final VoidCallback? onTap;
  const RoundedButton({
    Key? key,
    this.enable = true,
    this.radius = 10.0,
    this.height = 44.0,
    this.width = double.maxFinite,
    this.title,
    this.outline = false,
    required this.onTap,
    this.color = AppColors.PRIMARY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: context.textTheme().button,
      minimumSize: Size(width, height),
      primary: enable
          ? outline
              ? Colors.white
              : color
          : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        side: enable ? BorderSide(color: color, width: 2) : BorderSide.none,
      ),
    );
    return ElevatedButton(
      onPressed: enable ? onTap : null,
      child: (title is String)
          ? Text(
              title,
              style: context.textTheme().button!.withColor(Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : title,
      style: buttonStyle,
    );
  }
}
