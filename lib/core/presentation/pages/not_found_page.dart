import 'package:flutter/material.dart';

import '../../utility/helper.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Text(
              getLocalizationString(context).pageIsNotFound,
            ),
          ),
        ),
      ),
    );
  }
}
