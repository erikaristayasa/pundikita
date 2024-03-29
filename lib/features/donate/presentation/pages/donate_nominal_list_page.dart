import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/campaign_entity.dart';
import '../../../../core/presentation/cubits/nominal_cubit.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/nominal_item.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import 'donate_request_inquiry_page.dart';

class DonateNominalListPageRouteArguments {
  final Campaign campaign;

  DonateNominalListPageRouteArguments({required this.campaign});
}

class DonateNominalListPage extends StatefulWidget {
  final Campaign campaign;
  const DonateNominalListPage({Key? key, required this.campaign}) : super(key: key);

  @override
  State<DonateNominalListPage> createState() => _DonateNominalListPageState();
}

class _DonateNominalListPageState extends State<DonateNominalListPage> {
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
    return BlocProvider(
      create: (_) => NominalCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: AppLocale.loc.donate,
          canBack: true,
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
                      AppLocale.loc.chooseDonateNominal,
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
                        mediumVerticalSpacing(),
                        RoundedButton(
                          enable: state != null,
                          onTap: () => Navigator.pushNamed(
                            context,
                            path.DONATION_REQUEST_INQURY,
                            arguments: DonateRequestInquiryPageRouteArguments(
                              nominal: state!.toInt(),
                              campaign: widget.campaign,
                            ),
                          ),
                          title: AppLocale.loc.next,
                        ),
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
