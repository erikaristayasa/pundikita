import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../static/colors.dart';
import '../../static/dimens.dart';
import '../../static/enums.dart';
import '../../static/extensions.dart';
import '../../utility/app_locale.dart';
import '../../utility/helper.dart';
import '../../utility/locator.dart';
import '../cubits/payment_method/payment_method_cubit.dart';
import '../cubits/wallet_saldo_cubit.dart';
import 'payment_method_item.dart';

class BottomSheetPaymentMethod extends StatelessWidget {
  final bool showWallet;
  final num? nominal;
  const BottomSheetPaymentMethod({Key? key, this.showWallet = true, this.nominal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Container(
        height: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimension.MEDIUM),
              child: Text(
                AppLocale.loc.choosePaymentMethod,
                style: context.textTheme().titleMedium,
              ),
            ),
            Expanded(
              child: BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
                builder: (context, state) {
                  final bloc = context.read<PaymentMethodCubit>();
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      showWallet
                          ? BlocProvider(
                              create: (context) => locator<WalletSaldoCubit>()..getSaldo(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const PaymentSection(sectionName: 'Pundi Kebaikan'),
                                  BlocBuilder<WalletSaldoCubit, num>(builder: (context, state) {
                                    final _isEnough = state >= (nominal ?? 0);
                                    return PaymentMethodItem(
                                      subtitle: 'Saldo anda saat ini ${getFormattedPrice(state.toInt())}',
                                      onSelect: (method, channel) {
                                        if (_isEnough) {
                                          bloc.select(method: method, channel: channel);
                                        } else {
                                          Fluttertoast.showToast(msg: 'Maaf saldo anda tidak mencukupi.');
                                        }
                                      },
                                      selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.saldo),
                                      method: PaymentMethod.saldo,
                                      channel: PaymentChannel.saldo,
                                    );
                                  }),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      const PaymentSection(sectionName: 'QRIS'),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.qris),
                        method: PaymentMethod.qris,
                        channel: PaymentChannel.qris,
                      ),
                      const PaymentSection(sectionName: 'Virtual Account'),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.bag),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bag,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.bca),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bca,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.bni),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bni,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.cimb),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.cimb,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.mandiri),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.mandiri,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.bmi),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bmi,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.bri),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bri,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.bsi),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bsi,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<PaymentMethodCubit>().isSelected(PaymentChannel.permata),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.permata,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentSection extends StatelessWidget {
  final String sectionName;
  const PaymentSection({Key? key, required this.sectionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BG_Grey,
      padding: const EdgeInsets.all(Dimension.SMALL),
      child: Text(
        sectionName,
        style: context.textTheme().labelSmall,
      ),
    );
  }
}
