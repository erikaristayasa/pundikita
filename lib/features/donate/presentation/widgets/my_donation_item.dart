import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/extensions.dart';

import '../../../../core/domain/entities/donation_entity.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/helper.dart';
import '../pages/donate_request_inquiry_result_page.dart';

class MyDonationItem extends StatelessWidget {
  final Donation donation;
  const MyDonationItem({Key? key, required this.donation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: ListTile(
        onTap: () => Navigator.pushNamed(
          context,
          path.DONATION_REQUEST_INQURY_RESULT,
          arguments: DonateRequestInquiryResultPageRouteArguments(result: donation),
        ),
        title: Text(
          getFormattedPrice(donation.amountOfFunds.toInt()),
        ),
        subtitle: Text(donation.pray ?? ''),
        trailing: Builder(builder: (_) {
          String _asset = '';
          String _status = '';
          switch (donation.status) {
            case DonationPayStatus.pending:
              _asset = Assets.PAYMENT_PENDING;
              _status = 'Pembayaran tertunda';
              break;
            case DonationPayStatus.paid:
              _asset = Assets.PAYMENT_PAID;
              _status = 'Telah dibayar';
              break;
            case DonationPayStatus.failed:
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
