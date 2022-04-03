import 'package:flutter/material.dart';

import '../../static/dimens.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? height;
  final double? width;
  final double radius;
  final bool shadow;
  final EdgeInsetsGeometry? padding;
  final Clip clipBerhaviour;
  const RoundedContainer({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.height,
    this.radius = Dimension.SMALL,
    this.shadow = false,
    this.padding = const EdgeInsets.all(Dimension.SMALL),
    this.clipBerhaviour = Clip.none,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      clipBehavior: clipBerhaviour,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          (shadow)
              ? BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
              : const BoxShadow(color: Colors.transparent)
        ],
      ),
      child: child,
    );
  }
}
