import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../cubit/payment_method/donate_payment_method_cubit.dart';
import 'payment_method_item.dart';

class BottomSheetPaymentMethod extends StatelessWidget {
  const BottomSheetPaymentMethod({Key? key}) : super(key: key);

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
              child: BlocBuilder<DonatePaymentMethodCubit, DonatePaymentMethodState>(
                builder: (context, state) {
                  final bloc = context.read<DonatePaymentMethodCubit>();
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      const PaymentSection(sectionName: 'Dompet'),
                      PaymentMethodItem(
                        subtitle: 'Saldo anda saat ini Rp0',
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.saldo),
                        method: PaymentMethod.saldo,
                        channel: PaymentChannel.saldo,
                      ),
                      const PaymentSection(sectionName: 'QRIS'),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.qris),
                        method: PaymentMethod.qris,
                        channel: PaymentChannel.qris,
                      ),
                      const PaymentSection(sectionName: 'Virtual Account'),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.bag),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bag,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.bca),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bca,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.bni),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bni,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.cimb),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.cimb,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.mandiri),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.mandiri,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.bmi),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bmi,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.bri),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bri,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.bsi),
                        method: PaymentMethod.va,
                        channel: PaymentChannel.bsi,
                      ),
                      PaymentMethodItem(
                        onSelect: (method, channel) => bloc.select(method: method, channel: channel),
                        selected: context.watch<DonatePaymentMethodCubit>().isSelected(PaymentChannel.permata),
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
