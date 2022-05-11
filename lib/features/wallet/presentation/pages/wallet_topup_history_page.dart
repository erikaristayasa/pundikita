import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/pages/no_data_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/history/wallet_topup_history_bloc.dart';
import '../widgets/topup_history_item.dart';

class WalletTopUpHistoryPage extends StatelessWidget {
  const WalletTopUpHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<WalletTopupHistoryBloc>()..add(FetchData()),
      child: Scaffold(
          backgroundColor: AppColors.BG_Grey,
          appBar: const CustomAppBar(
            title: 'Riwayat Isi Ulang',
            canBack: true,
          ),
          body: BlocBuilder<WalletTopupHistoryBloc, WalletTopupHistoryState>(
            builder: (context, state) {
              if (state is WalletTopupHistoryLoaded) {
                final _data = state.data;
                if (_data.isNotEmpty) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(Dimension.MEDIUM),
                    itemBuilder: (context, index) => TopUpHistoryItem(
                      result: _data.elementAt(index),
                    ),
                    separatorBuilder: (_, __) => mediumVerticalSpacing(),
                    itemCount: _data.length,
                  );
                }
              } else if (state is WalletTopupHistoryLoading) {
                return const LoadingPage(isList: true);
              }
              return const NoDataPage();
            },
          )),
    );
  }
}
