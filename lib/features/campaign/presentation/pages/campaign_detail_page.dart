import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/pages/not_found_page.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../../../donate/presentation/pages/donate_nominal_list_page.dart';
import '../bloc/detail/campaign_detail_bloc.dart';
import '../cubit/campaign_bottom_button.dart';
import '../cubit/campaign_title_cubit.dart';
import '../widgets/campaign_basic_info.dart';
import '../widgets/campaign_fundraiser_info.dart';
import '../widgets/campaign_prays.dart';
import '../widgets/campaign_story.dart';

class CampaignDetailPageRouteArguments {
  final num id;
  final CampaignService service;

  CampaignDetailPageRouteArguments({required this.id, required this.service});
}

class CampaignDetailPage extends StatefulWidget {
  final num id;
  final CampaignService service;
  const CampaignDetailPage({Key? key, required this.id, required this.service}) : super(key: key);

  @override
  State<CampaignDetailPage> createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
  final ScrollController _controller = ScrollController();
  final CampaignTitleCubit campaignTitleCubit = CampaignTitleCubit("");
  final CampaignBottomButtonCubit campaignBottomButtonCubit = CampaignBottomButtonCubit(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _scrollListener());
  }

  _scrollListener() {
    if (_controller.offset >= 200) {
      campaignTitleCubit.change();
      campaignBottomButtonCubit.show();
    }
    if (_controller.offset < 200) {
      campaignTitleCubit.change(title: "");
      campaignBottomButtonCubit.hide();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CampaignDetailBloc>(
      create: (_) => locator<CampaignDetailBloc>()..add(GetDetail(widget.id, widget.service)),
      child: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case CampaignDetailLoaded:
              final Campaign campaign = (state as CampaignDetailLoaded).data;
              campaignTitleCubit.setTitle(title: campaign.title ?? '');
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
                          getCampaignImageUrl(campaign.photo ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      elevation: 0.0,
                      floating: false,
                      pinned: true,
                      snap: false,
                      stretch: true,
                      collapsedHeight: kToolbarHeight,
                      expandedHeight: 300,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CampaignBasicInfo(campaign: campaign),
                            smallVerticalSpacing(),
                            CampaignFundraiserInfo(campaign: campaign),
                            smallVerticalSpacing(),
                            CampaignStory(story: campaign.story ?? ''),
                            smallVerticalSpacing(),
                            CampaignPrays(donations: campaign.donation),
                          ],
                        ),
                        childCount: 1,
                      ),
                    )
                  ],
                ),
                bottomNavigationBar: BlocBuilder<CampaignBottomButtonCubit, bool>(
                  bloc: campaignBottomButtonCubit,
                  builder: (context, show) => show
                      ? Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(Dimension.MEDIUM),
                          child: RoundedButton(
                            radius: 22,
                            onTap: () => Navigator.pushNamed(
                              context,
                              path.DONATION_NOMINAL_LIST,
                              arguments: DonateNominalListPageRouteArguments(campaignId: campaign.id),
                            ),
                            title: widget.service == CampaignService.donasi ? AppLocale.loc.donateNow : AppLocale.loc.zakatNow,
                            color: widget.service == CampaignService.donasi ? Colors.red : Colors.blue,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              );
            case CampaignDetailFailure:
              return const NotFoundPage();
            default:
              return const LoadingPage();
          }
        },
      ),
    );
  }
}
