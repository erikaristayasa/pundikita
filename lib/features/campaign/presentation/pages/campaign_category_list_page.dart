import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/pages/not_found_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/category/campaign_category_bloc.dart';
import '../widgets/campaign_category_item.dart';

class CampaignCategoryListPageRouteArguments {
  final CampaignType type;

  CampaignCategoryListPageRouteArguments({required this.type});
}

class CampaignCategoryListPage extends StatelessWidget {
  final CampaignType type;
  const CampaignCategoryListPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<CampaignCategoryBloc>()..add(GetData()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Kategori Galang Dana',
          canBack: true,
        ),
        body: SafeArea(child: BlocBuilder<CampaignCategoryBloc, CampaignCategoryState>(
          builder: (context, state) {
            if (state is CampaignCategoryLoaded) {
              final _data = state.data;
              return ListView.separated(
                itemBuilder: (context, index) => CampaignCategoryItem(
                  type: type,
                  category: _data.elementAt(index),
                ),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: _data.length,
              );
            } else if (state is CampaignCategoryFailure) {
              return const NotFoundPage();
            } else if (state is CampaignCategoryLoading) {
              return const LoadingPage(isList: true);
            }
            return const SizedBox.expand();
          },
        )),
      ),
    );
  }
}
