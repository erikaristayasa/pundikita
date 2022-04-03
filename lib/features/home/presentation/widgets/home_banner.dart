import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pundi_kita/core/presentation/widgets/rounded_container.dart';
import 'package:pundi_kita/core/static/colors.dart';
import 'package:pundi_kita/core/static/dimens.dart';
import 'package:pundi_kita/core/utility/helper.dart';

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

    images = List<Widget>.generate(
      5,
      (index) => RoundedContainer(
        color: Colors.black,
        child: Center(
          child: FlutterLogo(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: images,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 4.5 / 2,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          mediumVerticalSpacing(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
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
      ),
    );
  }
}
