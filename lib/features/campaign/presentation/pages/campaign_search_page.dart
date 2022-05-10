import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/presentation/pages/loading_page.dart';
import 'package:pundi_kita/core/presentation/pages/no_data_page.dart';
import 'package:pundi_kita/core/utility/locator.dart';

import '../bloc/list/campaign_list_bloc.dart';
import '../widgets/campaign_item.dart';
import '../widgets/campaign_searchbar.dart';

class CampaignSearchPage extends StatefulWidget {
  const CampaignSearchPage({Key? key}) : super(key: key);

  @override
  State<CampaignSearchPage> createState() => _CampaignSearchPageState();
}

class _CampaignSearchPageState extends State<CampaignSearchPage> {
  final _keywordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _keywordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<CampaignListBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<CampaignListBloc, CampaignListState>(
                buildWhen: (previous, current) => current == CampaignListInitial(),
                builder: (context, _) {
                  return CampaignSearchBar(
                    controller: _keywordController,
                    onSearch: (value) {
                      context.read<CampaignListBloc>().add(SearchingCampaign(keyword: value));
                    },
                  );
                },
              ),
              Expanded(child: BlocBuilder<CampaignListBloc, CampaignListState>(
                builder: (context, state) {
                  if (state is CampaignListLoading) {
                    return const LoadingPage(isList: true);
                  } else if (state is CampaignListLoaded) {
                    final data = state.data;
                    return ListView.separated(
                      itemBuilder: (context, index) => CampaignItem(
                        campaign: data.elementAt(index),
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data.length,
                    );
                  }
                  return const NoDataPage();
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
