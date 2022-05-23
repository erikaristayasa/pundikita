import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/blocs/all_donation/all_donation_bloc.dart';
import '../../../../core/presentation/blocs/banner/banner_bloc.dart';
import '../../../../core/presentation/blocs/banner/random_banner_bloc.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../widgets/home_all_donation.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_campaign_list.dart';
import '../widgets/home_campaign_service.dart';
import '../widgets/home_single_banner.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<BannerBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<RandomBannerBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<AllDonationBloc>(),
        )
      ],
      child: Scaffold(
        backgroundColor: AppColors.BG_Grey,
        appBar: const SearchBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // padding: const EdgeInsets.symmetric(vertical: Dimension.SMALL),
              children: [
                const HomeBanner(),
                smallVerticalSpacing(),
                const HomeCampaignService(),
                smallVerticalSpacing(),
                const HomeCampaignList(
                  labelText: 'Mulai Berbagi Yuk...',
                  service: CampaignService.donasi,
                ),
                smallVerticalSpacing(),
                const HomeSingleBanner(),
                smallVerticalSpacing(),
                const HomeCampaignList(
                  labelText: 'Program Khusus Pundikita',
                  service: CampaignService.zakat,
                ),
                smallVerticalSpacing(),
                const HomeAllDonation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
