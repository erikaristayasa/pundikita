import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/features/donate/presentation/widgets/payment_method_item.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../cubit/donate_pray_dubit.dart';
import '../cubit/payment_method/donate_payment_method_cubit.dart';
import '../widgets/bottom_sheet_payment_method.dart';
import '../widgets/donate_form.dart';

class DonateRequestInquiryPageRouteArguments {
  final int nominal;
  final int campaignId;

  DonateRequestInquiryPageRouteArguments({required this.campaignId, required this.nominal});
}

class DonateRequestInquiryPage extends StatelessWidget {
  final int nominal;
  final int campaignId;
  const DonateRequestInquiryPage({Key? key, required this.nominal, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DonatePrayCubit>(create: (_) => DonatePrayCubit()),
        BlocProvider<DonatePaymentMethodCubit>(create: (_) => DonatePaymentMethodCubit()),
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
          child: MultiBlocListener(
            listeners: [
              BlocListener<DonatePrayCubit, String>(
                listener: (context, state) => logMe(state),
              )
            ],
            child: RoundedButton(
              onTap: () {},
              title: AppLocale.loc.continuePayment,
            ),
          ),
        ),
      ),
    );
  }
}
