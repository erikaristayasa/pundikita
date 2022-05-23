import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/pages/no_data_page.dart';
import '../../../../core/presentation/widgets/custom_label.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../../../campaign/presentation/bloc/list/campaign_list_bloc.dart';
import '../../../campaign/presentation/pages/campaign_all_page.dart';
import 'home_campaign_item.dart';

class HomeCampaignList extends StatefulWidget {
  final String labelText;
  final CampaignService service;
  const HomeCampaignList({Key? key, required this.labelText, required this.service}) : super(key: key);

  @override
  State<HomeCampaignList> createState() => _HomeCampaignListState();
}

class _HomeCampaignListState extends State<HomeCampaignList> {
  final _bloc = locator<CampaignListBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetCampaignList(widget.service, auth: false, sort: true));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomLabel(title: widget.labelText),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, path.CAMPAIGN_ALL, arguments: CampaignAllPageRouteArguments(service: widget.service)),
                child: Text(
                  AppLocale.loc.seeMore,
                  style: context.textTheme().bodySmall!.withColor(AppColors.SECONDARY),
                ),
              )
            ],
          ),
          mediumVerticalSpacing(),
          SizedBox(
            height: 350,
            child: BlocBuilder<CampaignListBloc, CampaignListState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is CampaignListLoaded) {
                  final data = state.data.take(5);
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: Dimension.MEDIUM),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) => HomeCampaignItem(
                      campaign: data.elementAt(index),
                    ),
                    separatorBuilder: (context, index) => mediumHorizontalSpacing(),
                  );
                } else if (state is CampaignListFailure) {
                  return Center(
                    child: Text(AppLocale.loc.unexpectedServerError),
                  );
                } else if (state is CampaignListInitial) {
                  return const NoDataPage();
                } else {
                  return const LoadingPage(isList: true);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
