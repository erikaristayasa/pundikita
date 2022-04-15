import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/features/donate/presentation/cubit/payment_method/donate_payment_method_cubit.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../cubit/donate_pray_dubit.dart';
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
                      style: context.textTheme().headlineMedium,
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        AppLocale.loc.paymentMethod,
                        style: context.textTheme().bodyMedium,
                      ),
                    ),
                    RoundedButton(
                      width: 80,
                      radius: 20,
                      onTap: () {},
                      title: AppLocale.loc.choose,
                    )
                  ],
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
