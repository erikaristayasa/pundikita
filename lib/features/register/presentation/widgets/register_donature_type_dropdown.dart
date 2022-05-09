import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../cubit/donature_type_cubit.dart';

class RegisterDonatureTypeDropDown extends StatelessWidget {
  const RegisterDonatureTypeDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonatureTypeCubit, DonatureType>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tipe Donatur',
              style: context.textTheme().titleSmall,
            ),
            const SizedBox(height: 4.0),
            RoundedContainer(
              color: Colors.grey[200]!,
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: Dimension.MEDIUM),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<DonatureType>(
                  value: state,
                  items: DonatureType.values
                      .map(
                        (e) => DropdownMenuItem<DonatureType>(
                          value: e,
                          child: Text(
                            e.getString(),
                            style: context.textTheme().titleMedium,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => context.read<DonatureTypeCubit>().change(value!),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
