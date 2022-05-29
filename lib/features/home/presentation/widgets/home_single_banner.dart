import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/blocs/banner/random_banner_bloc.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/enums.dart';
import '../../../../core/utility/helper.dart';
import '../../../campaign/presentation/pages/campaign_detail_page.dart';

class HomeSingleBanner extends StatefulWidget {
  const HomeSingleBanner({Key? key}) : super(key: key);

  @override
  State<HomeSingleBanner> createState() => _HomeSingleBannerState();
}

class _HomeSingleBannerState extends State<HomeSingleBanner> {
  @override
  void initState() {
    super.initState();
    context.read<RandomBannerBloc>().add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BlocBuilder<RandomBannerBloc, RandomBannerState>(
        builder: (context, state) {
          if (state is RandomBannerLoaded) {
            final _data = state.data;
            return InkWell(
              onTap: () {
                if (_data.campaingId != null) {
                  Navigator.pushNamed(
                    context,
                    path.CAMPAIGN_DETAIL,
                    arguments: CampaignDetailPageRouteArguments(id: _data.campaingId!, service: CampaignService.donasi),
                  );
                }
              },
              child: Image.network(
                getBannerImageUrl(_data.photo),
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
