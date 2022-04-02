import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NavbarIcon extends StatelessWidget {
  final String asset;
  final AnimationController controller;
  const NavbarIcon({Key? key, required this.asset, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        asset,
        controller: controller,
        height: 34,
        width: 34,
        fit: BoxFit.fill,
      ),
    );
  }
}
