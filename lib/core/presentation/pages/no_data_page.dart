import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../static/assets.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Center(
            child: LottieBuilder.asset(
              Assets.LOTTIE_NO_DATA,
              fit: BoxFit.fitWidth,
              width: 150,
            ),
          ),
        ),
      ),
    );
  }
}
