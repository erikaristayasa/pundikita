import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/static/dimens.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/pages/not_found_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../../domain/entities/faq_entity.dart';
import '../bloc/faq_bloc.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<FaqBloc>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: AppLocale.loc.faq,
          canBack: true,
        ),
        body: BlocConsumer<FaqBloc, FaqState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FaqLoaded) {
              final List<Faq> _data = state.data as List<Faq>;
              return ListView.separated(
                padding: const EdgeInsets.all(Dimension.SMALL),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  title: Text('● ' + _data[index].question),
                  subtitle: Text(_data[index].answers),
                ),
                separatorBuilder: (_, __) => mediumVerticalSpacing(),
                itemCount: _data.length,
              );
            } else if (state is Failure) {
              return const NotFoundPage(enableBack: false);
            } else if (state is FaqInitial) {
              context.read<FaqBloc>().add(FetchFaq());
            }
            return const LoadingPage(isList: true);
          },
        ),
      ),
    );
  }
}
