import 'package:flutter/material.dart';

import '../../../../core/static/colors.dart';

class ProfilePhotoContainer extends StatelessWidget {
  final ImageProvider? file;
  final ImageProvider? network;
  const ProfilePhotoContainer({Key? key, this.file, this.network}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.SECONDARY.withOpacity(0.15),
      foregroundImage: file ?? network,
    );
  }
}
