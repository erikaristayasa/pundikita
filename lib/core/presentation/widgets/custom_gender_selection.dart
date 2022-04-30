import 'package:flutter/material.dart';

import '../../static/enums.dart';
import '../../static/extensions.dart';
import '../../utility/helper.dart';

class CustomGenderSelection extends StatelessWidget {
  final String? title;
  final ValueChanged<Gender> onChanged;
  final Gender groupValue;
  const CustomGenderSelection({Key? key, required this.onChanged, this.title, required this.groupValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? 'Jenis Kelamin',
          style: context.textTheme().titleSmall,
        ),
        smallVerticalSpacing(),
        Column(
          children: Gender.values
              .map(
                (e) => LabeledRadio(
                  label: e.getString(),
                  padding: const EdgeInsets.all(0),
                  groupValue: groupValue,
                  value: e,
                  onChanged: onChanged,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final Gender groupValue;
  final Gender value;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<Gender>(
              groupValue: groupValue,
              value: value,
              onChanged: (Gender? newValue) {
                onChanged(newValue!);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
