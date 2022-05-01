import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/pages/no_data_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/custom_label.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/list/campaign_list_bloc.dart';
import '../widgets/campaign_item.dart';

class MyCampaignPage extends StatefulWidget {
  const MyCampaignPage({Key? key}) : super(key: key);

  @override
  State<MyCampaignPage> createState() => _MyCampaignPageState();
}

class _MyCampaignPageState extends State<MyCampaignPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<CampaignListBloc>()..add(const GetCampaignList(CampaignService.donasi, auth: true)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: AppLocale.loc.raiseFunds,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimension.MEDIUM),
                child: RoundedButton(
                  outline: true,
                  title: 'Buat Galang Dana Baru',
                  titleColor: AppColors.PRIMARY,
                  onTap: () => Navigator.pushNamed(context, path.CAMPAIGN_CREATE),
                ),
              ),
              Expanded(
                child: BlocBuilder<CampaignListBloc, CampaignListState>(
                  builder: (context, state) {
                    if (state is CampaignListLoaded) {
                      final _data = state.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimension.MEDIUM),
                            child: CustomLabel(title: 'Kelola galang dana'),
                          ),
                          mediumVerticalSpacing(),
                          Expanded(
                            child: _data.isEmpty
                                ? const NoDataPage()
                                : ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => CampaignItem(campaign: _data.elementAt(index)),
                                    separatorBuilder: (_, __) => mediumVerticalSpacing(),
                                    itemCount: _data.length,
                                  ),
                          )
                        ],
                      );
                    } else if (state is CampaignListLoading) {
                      return const LoadingPage(isList: true);
                    }
                    return const SizedBox.expand();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
