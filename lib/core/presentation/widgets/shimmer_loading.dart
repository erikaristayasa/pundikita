import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../static/assets.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      Assets.LOTTIE_SHIMMER,
      width: double.maxFinite,
      height: double.maxFinite,
      fit: BoxFit.cover,
      repeat: true,
    );
  }
}
