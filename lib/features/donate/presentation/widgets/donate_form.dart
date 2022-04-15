import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/features/donate/presentation/cubit/donate_pray_dubit.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../../../../core/utility/shared_preferences_helper.dart';

class DonateForm extends StatelessWidget {
  const DonateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 250,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<SharedPreferencesHelper>(
            future: locator.getAsync<SharedPreferencesHelper>(),
            builder: (context, snap) {
              if (snap.hasData) {
                final _ = snap.data!;
                //TODO: get profile data.
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'session.userName',
                      style: context.textTheme().titleSmall,
                    ),
                    Text(
                      'session.userEmail',
                      style: context.textTheme().bodySmall,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const Divider(),
          Text(
            'Doa untuk donasi ini (opsional)',
            style: context.textTheme().labelMedium,
          ),
          mediumVerticalSpacing(),
          Expanded(
            child: TextFormField(
              onChanged: (value) => context.read<DonatePrayCubit>().onChanged(value),
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
