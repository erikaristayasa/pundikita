import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/presentation/blocs/banner/banner_bloc.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/helper.dart';
import '../../../campaign/presentation/pages/campaign_detail_page.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  late List<Widget> images;

  @override
  void initState() {
    super.initState();
    context.read<BannerBloc>().add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.SMALL),
      child: BlocBuilder<BannerBloc, BannerState>(
        builder: (context, state) {
          if (state is BannerLoaded) {
            final _banners = state.data;
            final _images = List<Widget>.from(
              _banners.map(
                (e) => RoundedContainer(
                  padding: const EdgeInsets.all(0.0),
                  width: double.maxFinite,
                  color: Colors.black,
                  clipBerhaviour: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      if (e.campaingId != null) {
                        Navigator.pushNamed(
                          context,
                          path.CAMPAIGN_DETAIL,
                          arguments: CampaignDetailPageRouteArguments(id: e.campaingId!, service: CampaignService.donasi),
                        );
                      }
                    },
                    child: Image.network(
                      getBannerImageUrl(e.photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );

            return Column(
              children: [
                Expanded(
                  child: CarouselSlider(
                    items: _images,
                    carouselController: _controller,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      // aspectRatio: 4.5 / 2,
                      aspectRatio: 4 / 2,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                ),
                smallVerticalSpacing(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: _current == entry.key ? 16.0 : 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: (AppColors.PRIMARY.withOpacity(_current == entry.key ? 1 : 0.4)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }
          return Center(
            child: LottieBuilder.asset(
              Assets.LOTTIE_LOADING_CAROUSEL,
              fit: BoxFit.fitHeight,
            ),
          );
        },
      ),
    );
  }
}
