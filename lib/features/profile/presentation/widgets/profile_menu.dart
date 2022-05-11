import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/extensions.dart';

class ProfileMenu extends StatelessWidget {
  final String asset;
  final VoidCallback onTap;
  final String title;
  final String? subtitle;
  final Color bgColor;
  const ProfileMenu({
    Key? key,
    required this.asset,
    required this.onTap,
    required this.title,
    this.subtitle,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: bgColor,
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(
          asset,
          width: 24.0,
          height: 24.0,
          fit: BoxFit.contain,
        ),
        title: Text(
          title,
          style: context.textTheme().titleSmall,
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: context.textTheme().labelSmall,
              )
            : null,
        dense: subtitle != null,
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
