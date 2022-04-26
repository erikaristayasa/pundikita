import 'package:flutter/material.dart';

import '../../static/assets.dart';
import '../../static/colors.dart';
import '../../static/dimens.dart';
import '../../static/extensions.dart';
import '../../utility/helper.dart';
import 'rounded_container.dart';

class BottomSheetImageSource extends StatelessWidget {
  final Function selectCamera;
  final Function selectGallery;
  const BottomSheetImageSource({Key? key, required this.selectCamera, required this.selectGallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = getLocalizationString(context);
    return Container(
      padding: const EdgeInsets.all(Dimension.SMALL),
      color: AppColors.BG_Grey,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimension.SMALL),
            child: InkWell(
              onTap: () => selectCamera(),
              child: RoundedContainer(
                height: null,
                child: ListTile(
                  dense: true,
                  leading: Image.asset(
                    Assets.CAMERA,
                    fit: BoxFit.fitHeight,
                    height: 22.0,
                  ),
                  title: Text(loc.camera, style: context.textTheme().titleSmall),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimension.SMALL),
            child: InkWell(
              onTap: () => selectGallery(),
              child: RoundedContainer(
                height: null,
                child: ListTile(
                  dense: true,
                  leading: Image.asset(
                    Assets.GALLERY,
                    fit: BoxFit.fitHeight,
                    height: 22.0,
                  ),
                  title: Text(loc.gallery, style: context.textTheme().titleSmall),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
