import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../static/assets.dart';

class LoadingPage extends StatelessWidget {
  final bool isList;
  const LoadingPage({Key? key, this.isList = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Center(
            child: LottieBuilder.asset(
              isList ? Assets.LOTTIE_LOADING_LIST : Assets.LOTTIE_LOADING_PAGE,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
