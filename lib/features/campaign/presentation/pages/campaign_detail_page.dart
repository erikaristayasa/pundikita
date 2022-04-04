import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/static/colors.dart';
import '../../../../core/utility/helper.dart';
import '../cubit/campaign_title_cubit.dart';
import '../widgets/campaign_basic_info.dart';
import '../widgets/campaign_fundraiser_info.dart';

class CampaignDetailPageRouteArguments {
  final num id;

  CampaignDetailPageRouteArguments({required this.id});
}

class CampaignDetailPage extends StatefulWidget {
  final num id;
  const CampaignDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CampaignDetailPage> createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
  final ScrollController _controller = ScrollController();
  final CampaignTitleCubit campaignTitleCubit = CampaignTitleCubit("");

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _scrollListener());
  }

  _scrollListener() {
    if (_controller.offset >= 200) {
      campaignTitleCubit.change("Campaign Title");
    }
    if (_controller.offset < 200) {
      campaignTitleCubit.change("");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_Grey,
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            leading: const BackButton(),
            title: BlocBuilder<CampaignTitleCubit, String>(
              bloc: campaignTitleCubit,
              builder: (context, state) => Text(state),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                getCampaignImageUrl('20220401143431-1648823671-BLE2uNRshhjBoDunrCygd2qu2vDGT2Z9txZmSavjeYUGsmqklB.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            elevation: 0.0,
            floating: true,
            pinned: true,
            snap: false,
            collapsedHeight: kToolbarHeight,
            expandedHeight: 300,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CampaignBasicInfo(),
                  smallVerticalSpacing(),
                  const CampaignFundraiserInfo(),
                  Container(
                    height: 200,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 200,
                    color: Colors.green,
                  )
                ],
              ),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
