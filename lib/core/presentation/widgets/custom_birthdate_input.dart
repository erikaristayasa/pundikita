import 'package:flutter/material.dart';

import '../../static/dimens.dart';
import '../../static/extensions.dart';
import '../../utility/helper.dart';
import 'rounded_container.dart';

class CustomBirthDateInput extends StatelessWidget {
  final String? title;
  final TextEditingController controller;
  final DateTime? birthDate;

  const CustomBirthDateInput({Key? key, required this.controller, this.birthDate, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showBirthDatePicker(DateTime? birthDate) async {
      final now = DateTime.now();
      final firstDate = DateTime(1900);
      await showDatePicker(context: context, initialDate: birthDate ?? now, firstDate: firstDate, lastDate: now).then(
        (value) {
          if (value != null) {
            controller.text = value.toText();
          }
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? 'Tanggal Lahir',
          style: context.textTheme().titleSmall,
        ),
        smallVerticalSpacing(),
        InkWell(
          onTap: () => showBirthDatePicker(birthDate),
          child: RoundedContainer(
            padding: const EdgeInsets.symmetric(horizontal: Dimension.MEDIUM),
            color: Colors.grey[200]!,
            height: 46.0,
            child: Row(
              children: [
                const Icon(Icons.calendar_month),
                mediumHorizontalSpacing(),
                Expanded(
                  child: TextField(
                    controller: controller,
                    enabled: false,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
