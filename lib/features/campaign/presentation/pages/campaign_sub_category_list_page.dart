import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/enums.dart' as e;
import '../../../../core/utility/locator.dart';
import '../bloc/sub_category/campaign_sub_category_bloc.dart';
import '../widgets/campaign_sub_category_item.dart';
import 'campaign_create_page.dart';

class CampaignSubCategoryListPageRouteArguments {
  final CampaignCategory category;
  CampaignSubCategoryListPageRouteArguments({required this.category});
}

class CampaignSubCategoryListPage extends StatelessWidget {
  final CampaignCategory category;
  const CampaignSubCategoryListPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<CampaignSubCategoryBloc>()..add(GetData(id: category.id)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: category.categoryName,
          canBack: true,
        ),
        body: SafeArea(child: BlocBuilder<CampaignSubCategoryBloc, CampaignSubCategoryState>(
          builder: (context, state) {
            if (state is CampaignSubCategoryLoaded) {
              final _data = state.data;
              return ListView.separated(
                itemBuilder: (context, index) => CampaignSubCategoryItem(
                  subCategory: _data.elementAt(index),
                  onTap: () {
                    Navigator.pushNamed(context, path.CAMPAIGN_CREATE, arguments: CampaignCreatePageRouteArguments(type: e.CampaignType.other));
                  },
                ),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: _data.length,
              );
            } else if (state is CampaignSubCategoryLoading) {
              return const LoadingPage(isList: true);
            }
            return const SizedBox.shrink();
          },
        )),
      ),
    );
  }
}
