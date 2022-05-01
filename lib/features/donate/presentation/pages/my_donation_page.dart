import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/pages/no_data_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/donation_list_bloc.dart';
import '../widgets/my_donation_empty.dart';
import '../widgets/my_donation_item.dart';

class MyDonationPage extends StatelessWidget {
  const MyDonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<DonationListBloc>()
        ..add(
          const GetData(service: CampaignService.donasi),
        ),
      child: Scaffold(
        backgroundColor: AppColors.BG_Grey,
        appBar: CustomAppBar(
          title: AppLocale.loc.myDonation,
        ),
        body: BlocBuilder<DonationListBloc, DonationListState>(
          builder: (context, state) {
            if (state is DonationListLoading) {
              return const LoadingPage(isList: true);
            } else if (state is DonationListLoaded) {
              final _data = state.data;
              if (_data.isEmpty) {
                return const MyDonationEmpty();
              }
              return ListView.separated(
                padding: const EdgeInsets.all(Dimension.MEDIUM),
                itemBuilder: (context, index) => MyDonationItem(donation: _data.elementAt(index)),
                separatorBuilder: (_, __) => mediumVerticalSpacing(),
                itemCount: _data.length,
              );
            }
            return const NoDataPage();
          },
        ),
      ),
    );
  }
}
