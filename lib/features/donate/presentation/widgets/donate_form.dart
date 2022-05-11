import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/presentation/cubits/user_info_cubit.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../cubit/donate_pray_dubit.dart';

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
          BlocBuilder<UserInfoCubit, User?>(
            bloc: locator<UserInfoCubit>()..getData(),
            builder: (context, state) {
              if (state != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.name ?? '',
                      style: context.textTheme().titleSmall,
                    ),
                    Text(
                      state.email ?? '',
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
