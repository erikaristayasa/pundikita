import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/assets.dart';

class DefaultImage extends StatelessWidget {
  const DefaultImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey[300]!,
      child: Image.asset(
        Assets.DEFAULT_IMAGE,
        fit: BoxFit.cover,
      ),
    );
  }
}
