import 'package:flutter/material.dart';

import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/helper.dart';

class BottomSheetResult extends StatelessWidget {
  final int result;
  const BottomSheetResult({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(Dimension.LARGE),
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimension.MEDIUM),
          topRight: Radius.circular(Dimension.MEDIUM),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 40.0,
            child: Divider(
              thickness: 2.0,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hasil Perhitungan Zakat',
                  style: context.textTheme().titleMedium,
                ),
                smallVerticalSpacing(),
                Text(
                  getFormattedPrice(result),
                  style: context.textTheme().headline6,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
