import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/zakat_calculate_bloc.dart';
import '../widgets/bottom_sheet_result.dart';

class ZakatCalculatePage extends StatefulWidget {
  const ZakatCalculatePage({Key? key}) : super(key: key);

  @override
  State<ZakatCalculatePage> createState() => _ZakatCalculatePageState();
}

class _ZakatCalculatePageState extends State<ZakatCalculatePage> {
  final _formKey = GlobalKey<FormState>();
  final _mothlyIncomeController = TextEditingController();
  final _mothlyOtherIncomeController = TextEditingController();
  final _mothlyInstallmentDebtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ZakatCalculateBloc>(),
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            canBack: true,
            title: 'Kalkulator Zakat',
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(Dimension.MEDIUM),
                children: [
                  CustomTextField(
                    title: "Penghasilan Perbulan",
                    inputType: TextInputType.number,
                    controller: _mothlyIncomeController,
                    validating: false,
                    prefixText: 'Rp',
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
                  CustomTextField(
                    title: "Penghasilan Lain Perbulan",
                    inputType: TextInputType.number,
                    controller: _mothlyOtherIncomeController,
                    validating: false,
                    prefixText: 'Rp',
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
                  CustomTextField(
                    title: "Hutang Cicilan Perbulan",
                    inputType: TextInputType.number,
                    controller: _mothlyInstallmentDebtController,
                    validating: false,
                    prefixText: 'Rp',
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyTextInputFormatter(
                        locale: 'id',
                        decimalDigits: 0,
                        symbol: '',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(Dimension.MEDIUM),
            color: Colors.white,
            child: BlocConsumer<ZakatCalculateBloc, ZakatCalculateState>(
              listener: (context, state) {
                if (state is ZakatCalculateFailure) {
                  Fluttertoast.showToast(msg: errorMessage(state.failure));
                  context.loaderOverlay.hide();
                } else if (state is ZakatCalculateLoading) {
                  context.loaderOverlay.show();
                } else if (state is ZakatCalculateSuccess) {
                  context.loaderOverlay.hide();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) => BottomSheetResult(result: state.data),
                  );
                }
              },
              builder: (context, state) {
                return RoundedButton(
                  title: 'Hitung Zakat',
                  onTap: () {
                    context.read<ZakatCalculateBloc>().add(
                          Calculate(
                            monthlyIncome: _mothlyIncomeController.text,
                            monthlyOtherIncome: _mothlyOtherIncomeController.text,
                            monthlyInstallmentDebt: _mothlyInstallmentDebtController.text,
                          ),
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
