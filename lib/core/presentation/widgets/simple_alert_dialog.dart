import 'package:flutter/material.dart';
import 'package:pundi_kita/core/utility/app_locale.dart';

class SimpleAlertDialog extends StatelessWidget {
  final String title, message;
  const SimpleAlertDialog({Key? key, required this.title, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(
        message,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [TextButton(onPressed: ()=> Navigator.pop(context), child: Text(AppLocale.loc.ok))],
    );
  }
}
