import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/domain/entities/donation_entity.dart';
import '../../../../core/presentation/pages/not_found_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';

class DonateRequestInquiryResultPageRouteArguments {
  final Donation result;
  DonateRequestInquiryResultPageRouteArguments({required this.result});
}

class DonateRequestInquiryResultPage extends StatelessWidget {
  final Donation result;
  const DonateRequestInquiryResultPage({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY,
      appBar: CustomAppBar(
        title: AppLocale.loc.paymentInformation,
        canBack: false,
        centerTitle: true,
        backgroundColor: AppColors.PRIMARY,
        textColor: Colors.white,
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            switch (result.paymentMethod) {
              case PaymentMethod.va:
                return VirtualAccountResult(
                  result: result,
                );
              case PaymentMethod.saldo:
                return DompetResult(result: result);
              case PaymentMethod.qris:
                return QrisResult(result: result);
              default:
                return const NotFoundPage();
            }
          },
        ),
      ),
    );
  }
}

class DompetResult extends StatelessWidget {
  final Donation result;
  const DompetResult({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimension.LARGE),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),
              child: Image.asset(
                Assets.PAYMENT_PAID,
                width: 150,
              ),
            ),
            largeVerticalSpacing(),
            Text(
              'Pembayaran berhasil',
              textAlign: TextAlign.center,
              style: context.textTheme().titleMedium!.withColor(Colors.white),
            ),
            smallVerticalSpacing(),
            Text(
              'Saldo telah terpotong otomatis.',
              textAlign: TextAlign.center,
              style: context.textTheme().bodySmall!.withColor(Colors.white),
            ),
            largeVerticalSpacing(),
            RoundedButton(
              color: Colors.white,
              title: AppLocale.loc.backToMainPage,
              titleColor: AppColors.PRIMARY,
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, path.MAIN, (route) => false),
            )
          ],
        ),
      ),
    );
  }
}

class QrisResult extends StatelessWidget {
  final Donation result;
  const QrisResult({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimension.LARGE),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),
              child: Image.asset(
                Assets.PAYMENT_PENDING,
                width: 150,
              ),
            ),
            largeVerticalSpacing(),
            Text(
              'Permintaan donasi berhasil dilakukan',
              textAlign: TextAlign.center,
              style: context.textTheme().titleMedium!.withColor(Colors.white),
            ),
            smallVerticalSpacing(),
            Text(
              'Silahkan melakukan pembayaran dengan pindai QR-code berikut.',
              textAlign: TextAlign.center,
              style: context.textTheme().bodySmall!.withColor(Colors.white),
            ),
            mediumVerticalSpacing(),
            AspectRatio(
              aspectRatio: 1 / 1,
              child: RoundedContainer(
                child: result.paymentNumber != null
                    ? QrImage(
                        data: result.paymentNumber!,
                        version: QrVersions.auto,
                        size: double.maxFinite,
                      )
                    : const SizedBox.expand(),
              ),
            ),
            smallVerticalSpacing(),
            Text(
              'Batas pembayaran: ${result.paymentExpired.toText(format: "dd/MM/yyyy HH:mm:ss")}',
              style: context.textTheme().labelSmall!.withColor(Colors.white),
            ),
            largeVerticalSpacing(),
            largeVerticalSpacing(),
            RoundedButton(
              color: Colors.white,
              title: AppLocale.loc.backToMainPage,
              titleColor: AppColors.PRIMARY,
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, path.MAIN, (route) => false),
            )
          ],
        ),
      ),
    );
  }
}

class VirtualAccountResult extends StatelessWidget {
  final Donation result;
  const VirtualAccountResult({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimension.LARGE),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),
              child: Image.asset(
                Assets.PAYMENT_PENDING,
                width: 150,
              ),
            ),
            largeVerticalSpacing(),
            Text(
              'Permintaan donasi berhasil dilakukan',
              textAlign: TextAlign.center,
              style: context.textTheme().titleMedium!.withColor(Colors.white),
            ),
            smallVerticalSpacing(),
            Text(
              'Silahkan melakukan pembayaran ke nomor virtual account berikut untuk menyelesaikan Donasi anda.',
              textAlign: TextAlign.center,
              style: context.textTheme().bodySmall!.withColor(Colors.white),
            ),
            mediumVerticalSpacing(),
            RoundedContainer(
              color: Colors.white.withOpacity(0.25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    result.paymentNumber ?? "Tidak tersedia",
                    style: context.textTheme().headline6!.withColor(Colors.white),
                  ),
                  IconButton(
                    onPressed: () => Clipboard.setData(
                      ClipboardData(text: result.paymentNumber),
                    ).then((value) => Fluttertoast.showToast(msg: "Disalin")),
                    icon: const Icon(
                      Icons.copy_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            smallVerticalSpacing(),
            Text(
              'Batas pembayaran: ${result.paymentExpired.toText(format: "dd/MM/yyyy HH:mm:ss")}',
              style: context.textTheme().labelSmall!.withColor(Colors.white),
            ),
            largeVerticalSpacing(),
            largeVerticalSpacing(),
            RoundedButton(
              color: Colors.white,
              title: AppLocale.loc.backToMainPage,
              titleColor: AppColors.PRIMARY,
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, path.MAIN, (route) => false),
            )
          ],
        ),
      ),
    );
  }
}
