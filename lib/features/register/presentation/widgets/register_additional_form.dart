import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/static/extensions.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../../../core/static/enums.dart';
import '../cubit/donature_type_cubit.dart';
import 'additional_forms/foundation_form.dart';
import 'additional_forms/personal_form.dart';

class RegisterAdditionalForm extends StatelessWidget {
  const RegisterAdditionalForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<DonatureTypeCubit, DonatureType>(
          builder: (context, state) {
            switch (state) {
              case DonatureType.personal:
                return const PersonalForm();
              case DonatureType.foundation:
                return const FoundationForm();
            }
          },
        ),
      ],
    );
  }
}
