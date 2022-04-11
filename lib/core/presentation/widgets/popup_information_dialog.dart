import 'package:flutter/material.dart';

import '../../static/assets.dart';

class PopUpInformationDialog extends StatelessWidget {
  const PopUpInformationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Image.asset(Assets.POPUP_INFORMATION),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              iconSize: 36.0,
              icon: const Icon(Icons.cancel),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
