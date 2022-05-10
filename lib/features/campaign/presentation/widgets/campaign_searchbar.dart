import 'package:flutter/material.dart';

import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';

class CampaignSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value) onSearch;
  const CampaignSearchBar({Key? key, required this.controller, required this.onSearch}) : super(key: key);
  static FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.PRIMARY,
      height: kToolbarHeight,
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(Dimension.SMALL),
        padding: const EdgeInsets.only(left: Dimension.MEDIUM),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((kToolbarHeight - Dimension.MEDIUM) / 2),
          color: Colors.white.withOpacity(0.25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextField(
                focusNode: focusNode..requestFocus(),
                maxLines: 1,
                controller: controller,
                style: context.textTheme().bodySmall!.withColor(Colors.white),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: onSearch,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0.0),
                  isDense: true,
                  hintText: AppLocale.loc.search,
                  hintStyle: context.textTheme().bodySmall!.withColor(Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: IconButton(
                splashRadius: 20.0,
                onPressed: () => onSearch(controller.text),
                icon: const Icon(Icons.search_rounded),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
