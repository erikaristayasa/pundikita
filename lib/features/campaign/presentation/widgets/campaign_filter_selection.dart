import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../bloc/category_filter/category_filter_bloc.dart';

class CampaignFilterSelection extends StatelessWidget {
  const CampaignFilterSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: RoundedContainer(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocale.loc.category,
              style: context.textTheme().titleMedium,
            ),
            const Divider(),
            AspectRatio(
              aspectRatio: 1 / 1,
              child: BlocBuilder<CategoryFilterBloc, CategoryFilterState>(builder: (context, state) {
                if (state is CategoryFilterLoaded) {
                  final _selectedData = state.selectedData;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final _category = state.data.elementAt(index);
                      return RadioListTile<CampaignCategory>(
                        title: Text(_category.categoryName ?? ''),
                        value: _category,
                        groupValue: _selectedData,
                        onChanged: (newValue) {
                          context.read<CategoryFilterBloc>().add(OnSelectCategory(category: newValue!));
                        },
                      );
                    },
                  );
                } else {
                  return const LoadingPage(isList: true);
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
