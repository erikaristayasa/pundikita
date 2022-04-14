import 'package:flutter/material.dart';

import '../../../../core/presentation/pages/no_data_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';

class FundUsageDetailUsageRouteArguments {
  final String usageDetail;
  FundUsageDetailUsageRouteArguments({required this.usageDetail});
}

class FundUsageDetailPage extends StatelessWidget {
  final String usageDetail;
  const FundUsageDetailPage({Key? key, required this.usageDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppLocale.loc.fundUsageDetail,
        canBack: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimension.MEDIUM),
          child: usageDetail.isEmpty
              ? const NoDataPage()
              : Text(
                  usageDetail,
                  style: context.textTheme().bodyMedium,
                ),
        ),
      ),
    );
  }
}
