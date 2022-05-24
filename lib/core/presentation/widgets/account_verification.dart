import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../../static/extensions.dart';
import '../../utility/helper.dart';
import 'validation_icon.dart';

class AccountVerificationField extends StatelessWidget {
  final User? user;
  const AccountVerificationField({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          getAccountVerificationType(user),
          style: context.textTheme().bodySmall,
        ),
        smallHorizontalSpacing(),
        ValidationIcon(isValidate: getAccountVerificationStatus(user)),
      ],
    );
  }
}
