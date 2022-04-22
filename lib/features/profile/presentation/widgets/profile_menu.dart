import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final String asset;
  final VoidCallback onTap;
  final String title;
  const ProfileMenu({Key? key, required this.asset, required this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: ListTile(
        leading: Image.asset(
          asset,
          width: 24.0,
          height: 24.0,
          fit: BoxFit.contain,
        ),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
