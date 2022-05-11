import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/helper.dart';
import '../../domain/entities/topup_result_entity.dart';
import '../pages/wallet_topup_result_page.dart';

class TopUpHistoryItem extends StatelessWidget {
  final TopUpResult result;
  const TopUpHistoryItem({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: ListTile(
        onTap: () {
          if (result.status == WalletTopUpPayStatus.pending) {
            Navigator.pushNamed(
              context,
              path.WALLET_TOP_UP_RESULT,
              arguments: WalletTopUpResultPageRouteArguments(result: result),
            );
          }
        },
        title: Text(
          getFormattedPrice(result.amount.toInt()),
          style: context.textTheme().titleSmall,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.paymentMethod.name,
              style: context.textTheme().labelSmall,
            ),
            Text(
              result.paymentChannel.title,
              style: context.textTheme().labelSmall,
            )
          ],
        ),
        trailing: Builder(builder: (_) {
          String _asset = '';
          String _status = '';
          switch (result.status) {
            case WalletTopUpPayStatus.pending:
              _asset = Assets.PAYMENT_PENDING;
              _status = 'Pembayaran tertunda';
              break;
            case WalletTopUpPayStatus.paid:
              _asset = Assets.PAYMENT_PAID;
              _status = 'Telah dibayar';
              break;
            case WalletTopUpPayStatus.failed:
              _asset = Assets.PAYMENT_FAILED;
              _status = 'Pembayaran Gagal';
              break;
          }
          return SizedBox(
            width: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  _asset,
                  width: 24.0,
                  fit: BoxFit.contain,
                ),
                Text(
                  _status,
                  style: context.textTheme().labelSmall,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
