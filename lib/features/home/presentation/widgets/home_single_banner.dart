import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/blocs/banner/random_banner_bloc.dart';
import '../../../../core/utility/helper.dart';

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
    return Container(
      height: 200,
      child: BlocBuilder<RandomBannerBloc, RandomBannerState>(
        builder: (context, state) {
          if (state is RandomBannerLoaded) {
            final _data = state.data;
            return Image.network(
              getBannerImageUrl(_data.photo),
              fit: BoxFit.cover,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
