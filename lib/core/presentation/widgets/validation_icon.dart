import 'package:flutter/material.dart';

class ValidationIcon extends StatelessWidget {
  final bool isValidate;
  const ValidationIcon({Key? key, required this.isValidate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_circle_rounded,
      size: 16.0,
      color: isValidate ? Colors.green.shade400 : Colors.grey.shade300,
    );
  }
}
