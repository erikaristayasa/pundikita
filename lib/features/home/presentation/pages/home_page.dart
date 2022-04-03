import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/colors.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../../../core/static/dimens.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_campaign_list.dart';
import '../widgets/home_campaign_type.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_Grey,
      appBar: const SearchBar(),
      body: SafeArea(
        child: ListView(
          // padding: const EdgeInsets.symmetric(vertical: Dimension.SMALL),
          children: [
            const HomeBanner(),
            smallVerticalSpacing(),
            const HomeCampaignType(),
            smallVerticalSpacing(),
            const HomeCampaignList(),
          ],
        ),
      ),
    );
  }
}
