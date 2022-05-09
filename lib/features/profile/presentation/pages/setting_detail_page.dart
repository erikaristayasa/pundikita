import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/dimens.dart';

class SettingDetailPageRouteArguments {
  final String title, content;

  SettingDetailPageRouteArguments({
    required this.title,
    required this.content,
  });
}

class SettingDetailPage extends StatelessWidget {
  final String title, content;
  const SettingDetailPage({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: title,
        canBack: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimension.SMALL),
          child: Html(
            data: content,
          ),
        ),
      ),
    );
  }
}
