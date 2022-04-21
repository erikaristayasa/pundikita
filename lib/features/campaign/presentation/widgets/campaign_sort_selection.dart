import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../bloc/sort/sort_bloc.dart';

class CampaignSortSelection extends StatelessWidget {
  const CampaignSortSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: RoundedContainer(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocale.loc.sort,
              style: context.textTheme().titleMedium,
            ),
            const Divider(),
            BlocBuilder<SortBloc, SortState>(
              builder: (context, state) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    CheckboxListTile(
                      value: (state as SortInitial).value,
                      title: Text(
                        AppLocale.loc.leastFunds,
                        style: context.textTheme().bodyMedium,
                      ),
                      onChanged: (value) {
                        context.read<SortBloc>().add(OnChanged(value: value ?? false));
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
