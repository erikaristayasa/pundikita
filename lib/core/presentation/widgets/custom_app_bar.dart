import 'package:flutter/material.dart';

import '../../static/colors.dart';
import '../../static/extensions.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool canBack;
  final bool centerTitle;
  final bool shadow;
  final List<Widget>? actions;
  const CustomAppBar({
    Key? key,
    this.title,
    this.canBack = false,
    this.centerTitle = false,
    this.shadow = false,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.PRIMARY,
      elevation: shadow ? 4.0 : 0.0,
      shadowColor: shadow ? Colors.black : Colors.transparent,
      leading: canBack
          ? IconButton(
              splashRadius: 26.0,
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_rounded),
            )
          : null,
      centerTitle: centerTitle,
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.headline6!.withColor(Colors.white),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
