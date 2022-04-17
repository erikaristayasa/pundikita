import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/request_inquiry_bloc.dart';
import '../cubit/donate_pray_dubit.dart';
import '../cubit/payment_method/donate_payment_method_cubit.dart';
import '../widgets/bottom_sheet_payment_method.dart';
import '../widgets/donate_form.dart';
import '../widgets/payment_method_item.dart';
import 'donate_request_inquiry_result_page.dart';

class DonateRequestInquiryPageRouteArguments {
  final int nominal;
  final Campaign campaign;

  DonateRequestInquiryPageRouteArguments({required this.campaign, required this.nominal});
}

class DonateRequestInquiryPage extends StatelessWidget {
  final int nominal;
  final Campaign campaign;
  const DonateRequestInquiryPage({Key? key, required this.nominal, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DonatePrayCubit>(create: (_) => DonatePrayCubit()),
          BlocProvider<DonatePaymentMethodCubit>(create: (_) => DonatePaymentMethodCubit()),
          BlocProvider<RequestInquiryBloc>(create: (_) => locator<RequestInquiryBloc>()),
        ],
        child: Scaffold(
          backgroundColor: AppColors.BG_Grey,
          appBar: CustomAppBar(
            title: AppLocale.loc.donate,
            canBack: true,
          ),
          body: SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(Dimension.MEDIUM),
              children: [
                RoundedContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocale.loc.totalPayment,
                        style: context.textTheme().titleSmall,
                      ),
                      Text(
                        getFormattedPrice(nominal),
                        style: context.textTheme().titleLarge,
                      ),
                    ],
                  ),
                ),
                mediumVerticalSpacing(),
                RoundedContainer(
                  padding: const EdgeInsets.all(Dimension.MEDIUM),
                  color: AppColors.SECONDARY.withOpacity(0.15),
                  child: Text(
                    AppLocale.loc.paymentWillVerifyAutomatically,
                    style: context.textTheme().labelSmall,
                  ),
                ),
                mediumVerticalSpacing(),
                RoundedContainer(
                  padding: const EdgeInsets.all(Dimension.MEDIUM),
                  height: 74,
                  child: BlocBuilder<DonatePaymentMethodCubit, DonatePaymentMethodState>(
                    builder: (context, state) {
                      Widget? firstChild;
                      if (state is DonatePaymentMethodEmpty) {
                        firstChild = Text(
                          AppLocale.loc.paymentMethod,
                          style: context.textTheme().bodyMedium,
                        );
                      } else {
                        final _state = state as DonatePaymentMethodSelected;

                        firstChild = PaymentMethodItem(
                          dense: true,
                          onSelect: (_, __) {},
                          method: _state.method,
                          channel: _state.channel,
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: firstChild,
                          ),
                          RoundedButton(
                            width: 80,
                            radius: 20,
                            onTap: () => showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (_) {
                                  return BlocProvider<DonatePaymentMethodCubit>.value(
                                    value: BlocProvider.of<DonatePaymentMethodCubit>(context),
                                    child: const BottomSheetPaymentMethod(),
                                  );
                                }),
                            title: AppLocale.loc.choose,
                          )
                        ],
                      );
                    },
                  ),
                ),
                mediumVerticalSpacing(),
                const DonateForm(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(Dimension.MEDIUM),
            child: BlocBuilder<DonatePrayCubit, String>(
              builder: (context, pray) {
                return BlocBuilder<DonatePaymentMethodCubit, DonatePaymentMethodState>(
                  builder: (context, paymentState) {
                    final _enable = paymentState is DonatePaymentMethodSelected;
                    return BlocConsumer<RequestInquiryBloc, RequestInquiryState>(
                      listener: (context, requestState) {
                        switch (requestState.runtimeType) {
                          case RequestInquiryFailure:
                            context.loaderOverlay.hide();
                            Fluttertoast.showToast(msg: AppLocale.loc.donationFailed);
                            break;
                          case RequestInquirySuccess:
                            context.loaderOverlay.hide();
                            final result = (requestState as RequestInquirySuccess).data;
                            Navigator.popAndPushNamed(
                              context,
                              path.DONATION_REQUEST_INQURY_RESULT,
                              arguments: DonateRequestInquiryResultPageRouteArguments(result: result),
                            );
                            break;
                          default:
                            if (!context.loaderOverlay.visible) context.loaderOverlay.show();
                        }
                      },
                      builder: (context, requestState) {
                        return RoundedButton(
                          enable: _enable,
                          onTap: () {
                            final _payment = (paymentState as DonatePaymentMethodSelected);
                            context.read<RequestInquiryBloc>().add(OnSubmit(
                                  campaign: campaign,
                                  method: _payment.method,
                                  channel: _payment.channel,
                                  pray: pray,
                                  nominal: nominal,
                                ));
                          },
                          title: AppLocale.loc.continuePayment,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
