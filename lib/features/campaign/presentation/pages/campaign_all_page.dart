import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/presentation/pages/loading_page.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/list/campaign_list_bloc.dart';
import '../widgets/campaign_item.dart';

class CampaignAllPageRouteArguments {
  final CampaignService service;

  CampaignAllPageRouteArguments({required this.service});
}

class CampaignAllPage extends StatefulWidget {
  final CampaignService service;
  const CampaignAllPage({Key? key, this.service = CampaignService.donasi}) : super(key: key);

  @override
  State<CampaignAllPage> createState() => _CampaignAllPageState();
}

class _CampaignAllPageState extends State<CampaignAllPage> {
  late String title;
  @override
  void initState() {
    super.initState();
    switch (widget.service) {
      case CampaignService.donasi:
        title = AppLocale.loc.donation;
        break;
      case CampaignService.zakat:
        title = AppLocale.loc.zakat;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<CampaignListBloc>()..add(GetCampaignList(widget.service)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: title,
          canBack: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.PRIMARY.withOpacity(0.2)),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        Assets.FILTER,
                        width: 18.0,
                      ),
                      label: Text(AppLocale.loc.category),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        Assets.SORT,
                        width: 18.0,
                      ),
                      label: Text(AppLocale.loc.sort),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<CampaignListBloc, CampaignListState>(
                  builder: (context, state) {
                    if (state is CampaignListLoaded) {
                      final data = state.data;
                      return ListView.separated(
                        itemBuilder: (context, index) => CampaignItem(
                          campaign: data.elementAt(index),
                        ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: data.length,
                      );
                    } else if (state is CampaignListFailure) {
                      return Center(
                        child: Text(AppLocale.loc.unexpectedServerError),
                      );
                    } else {
                      return const LoadingPage(isList: true);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
