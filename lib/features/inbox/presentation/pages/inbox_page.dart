import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/inbox_bloc.dart';
import '../widgets/inbox_item.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<InboxBloc>()..add(GetData()),
      child: Scaffold(
        backgroundColor: AppColors.BG_Grey,
        appBar: CustomAppBar(
          title: AppLocale.loc.inbox,
        ),
        body: BlocBuilder<InboxBloc, InboxState>(
          builder: (context, state) {
            if (state is InboxLoaded) {
              final _data = state.data;
              return ListView.separated(
                padding: const EdgeInsets.all(Dimension.MEDIUM),
                itemBuilder: (context, index) => InboxItem(inbox: _data.elementAt(index)),
                separatorBuilder: (_, __) => mediumVerticalSpacing(),
                itemCount: _data.length,
              );
            }
            return const LoadingPage(isList: true);
          },
        ),
      ),
    );
  }
}
