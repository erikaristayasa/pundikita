import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/type/campaign_type_bloc.dart';
import '../widgets/campaign_type_item.dart';

class CampaignTypeListPage extends StatelessWidget {
  const CampaignTypeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<CampaignTypeBloc>()..add(GetData()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: AppLocale.loc.raiseFunds,
          canBack: true,
        ),
        body: SafeArea(
          child: BlocBuilder<CampaignTypeBloc, CampaignTypeState>(
            builder: (context, state) {
              if (state is CampaignTypeLoaded) {
                final _data = state.data;
                return ListView.separated(
                  padding: const EdgeInsets.all(Dimension.MEDIUM),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CampaignTypeItem(
                    type: _data.elementAt(index),
                    onTap: () {
                      if (index != 0) {
                        Navigator.pushNamed(context, path.CAMPAIGN_CATEGORY);
                      }
                    },
                  ),
                  separatorBuilder: (_, __) => largeVerticalSpacing(),
                  itemCount: _data.length,
                );
              } else if (state is CampaignTypeLoading) {
                return const LoadingPage(isList: true);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
