import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/pages/no_data_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/category_filter/category_filter_bloc.dart';
import '../bloc/list/campaign_list_bloc.dart';
import '../bloc/sort/sort_bloc.dart';
import '../widgets/campaign_filter_selection.dart';
import '../widgets/campaign_item.dart';
import '../widgets/campaign_sort_selection.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<CampaignListBloc>()),
        BlocProvider(create: (_) => locator<CategoryFilterBloc>()..add(GetCategories())),
        BlocProvider(create: (_) => SortBloc()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: title,
          canBack: true,
          actions: widget.service == CampaignService.zakat
              ? [
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, path.ZAKAT_CALCULATE),
                    icon: const Icon(
                      Icons.calculate_rounded,
                      color: AppColors.PRIMARY,
                    ),
                  )
                ]
              : null,
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
                  mainAxisAlignment: widget.service == CampaignService.zakat ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<CategoryFilterBloc, CategoryFilterState>(builder: (context, _) {
                      if (widget.service == CampaignService.zakat) {
                        return const SizedBox.shrink();
                      }
                      return TextButton.icon(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => BlocProvider<CategoryFilterBloc>.value(
                            value: BlocProvider.of<CategoryFilterBloc>(context),
                            child: const CampaignFilterSelection(),
                          ),
                        ),
                        icon: Image.asset(
                          Assets.FILTER,
                          width: 18.0,
                        ),
                        label: Text(AppLocale.loc.category),
                      );
                    }),
                    BlocBuilder<SortBloc, SortState>(builder: (context, state) {
                      return TextButton.icon(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => BlocProvider<SortBloc>.value(
                            value: BlocProvider.of<SortBloc>(context),
                            child: const CampaignSortSelection(),
                          ),
                        ),
                        icon: Image.asset(
                          Assets.SORT,
                          width: 18.0,
                        ),
                        label: Text(AppLocale.loc.sort),
                      );
                    }),
                  ],
                ),
              ),
              Expanded(
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<SortBloc, SortState>(
                      listener: (context, state) {
                        final _categoryState = context.read<CategoryFilterBloc>().state;
                        if (_categoryState is CategoryFilterLoaded) {
                          context.read<CampaignListBloc>().add(GetCampaignList(widget.service, category: _categoryState.selectedData, sort: (state as SortInitial).value));
                        }
                      },
                    ),
                    BlocListener<CategoryFilterBloc, CategoryFilterState>(
                      listener: (context, state) {
                        final _sortState = context.read<SortBloc>().state;
                        if (state is CategoryFilterLoaded) {
                          context.read<CampaignListBloc>().add(GetCampaignList(widget.service, category: state.selectedData, sort: (_sortState as SortInitial).value));
                        }
                      },
                    ),
                  ],
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
                      } else if (state is CampaignListInitial) {
                        return const NoDataPage();
                      } else {
                        return const LoadingPage(isList: true);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
