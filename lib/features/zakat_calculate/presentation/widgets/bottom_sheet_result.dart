import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pundi_kita/core/static/colors.dart';

import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/helper.dart';

class BottomSheetResult extends StatelessWidget {
  final num result;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getFormattedPrice(result.round()),
                      style: context.textTheme().headline6,
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: (result.round()).toString()),
                        ).then((value) => Fluttertoast.showToast(msg: "Disalin"));
                      },
                      icon: const Icon(
                        Icons.copy_rounded,
                        color: AppColors.PRIMARY,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
