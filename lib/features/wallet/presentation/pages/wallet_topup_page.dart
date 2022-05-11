import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/cubits/nominal_cubit.dart';
import '../../../../core/presentation/cubits/payment_method/payment_method_cubit.dart';
import '../../../../core/presentation/widgets/bottom_sheet_payment_method.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/nominal_item.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/presentation/widgets/payment_method_item.dart';
import 'package:pundi_kita/core/routes/path.dart' as path;

class WalletTopUpPage extends StatefulWidget {
  const WalletTopUpPage({Key? key}) : super(key: key);

  @override
  State<WalletTopUpPage> createState() => _WalletTopUpPageState();
}

class _WalletTopUpPageState extends State<WalletTopUpPage> {
  final List<int> _nominal = [10000, 25000, 50000, 75000, 100000];
  final TextEditingController _otherNominalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _otherNominalController.addListener(() {
      final nominalString = _otherNominalController.text;
      nominalString.replaceFirst('0', '');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _otherNominalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NominalCubit()),
        BlocProvider(create: (_) => PaymentMethodCubit()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Isi Ulang Dompet',
          canBack: true,
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, path.WALLET_TOP_UP_HISTORY),
              icon: const Icon(
                Icons.history_rounded,
                color: AppColors.PRIMARY,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      'Pilih nominal',
                      style: context.textTheme().titleMedium,
                    ),
                  ),
                ),
                mediumVerticalSpacing(),
                Expanded(
                  child: ColoredBox(
                    color: AppColors.BG_Grey,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(Dimension.MEDIUM),
                      shrinkWrap: true,
                      itemCount: _nominal.length,
                      itemBuilder: (context, index) {
                        final value = _nominal.elementAt(index);
                        return NominalItem(
                          onSelect: (value) => context.read<NominalCubit>().onSelect(value),
                          nominal: value,
                          selected: context.watch<NominalCubit>().isSelected(value),
                        );
                      },
                      separatorBuilder: (contex, index) => mediumVerticalSpacing(),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(Dimension.MEDIUM),
                  child: BlocBuilder<NominalCubit, int?>(builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: AppLocale.loc.otherNominal + ' ', style: context.textTheme().labelLarge),
                              TextSpan(text: AppLocale.loc.minimumNominal, style: context.textTheme().labelSmall),
                            ],
                          ),
                        ),
                        smallVerticalSpacing(),
                        CustomTextField(
                          controller: _otherNominalController,
                          inputType: TextInputType.number,
                          prefixText: 'Rp',
                          onChange: (nominal) => context.read<NominalCubit>().onInput(nominal),
                          formatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyTextInputFormatter(
                              locale: 'id',
                              decimalDigits: 0,
                              symbol: '',
                            )
                          ],
                        ),
                        RoundedContainer(
                          padding: const EdgeInsets.all(Dimension.MEDIUM),
                          height: 74,
                          child: BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
                            builder: (context, state) {
                              Widget? firstChild;
                              if (state is PaymentMethodEmpty) {
                                firstChild = Text(
                                  AppLocale.loc.paymentMethod,
                                  style: context.textTheme().bodyMedium,
                                );
                              } else {
                                final _state = state as PaymentMethodSelected;

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
                                          return BlocProvider<PaymentMethodCubit>.value(
                                            value: BlocProvider.of<PaymentMethodCubit>(context),
                                            child: const BottomSheetPaymentMethod(showWallet: false),
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
                        BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
                          builder: (context, method) {
                            return RoundedButton(
                              enable: (state != null) && (method.runtimeType == PaymentMethodSelected),
                              onTap: () {},
                              title: AppLocale.loc.continuePayment,
                            );
                          },
                        )
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
