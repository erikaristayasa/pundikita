import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/zakat_calculate_bloc.dart';
import 'bottom_sheet_result.dart';

class MaalCalculate extends StatefulWidget {
  const MaalCalculate({Key? key}) : super(key: key);

  @override
  State<MaalCalculate> createState() => _MaalCalculateState();
}

class _MaalCalculateState extends State<MaalCalculate> {
  final _formKey = GlobalKey<FormState>();
  final _giroSavingsDepositValueController = TextEditingController();
  final _vehiclePropertyValueController = TextEditingController();
  final _goldSilverGgemsOrOthersController = TextEditingController();
  final _sharesReceivablesAndOtherSecuritiesContoller = TextEditingController();
  final _personalDebtDueThisYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ZakatCalculateBloc>(),
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(Dimension.MEDIUM),
                children: [
                  CustomTextField(
                    title: "Nilai Deposito/Tabungan/Giro",
                    inputType: TextInputType.number,
                    controller: _giroSavingsDepositValueController,
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
                    title: "Nilai properti & kendaraan",
                    inputType: TextInputType.number,
                    controller: _vehiclePropertyValueController,
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
                    title: "Emas, perak, permata atau lainnya",
                    inputType: TextInputType.number,
                    controller: _goldSilverGgemsOrOthersController,
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
                    title: "Saham, piutang, dan surat berhaga lainnya",
                    inputType: TextInputType.number,
                    controller: _sharesReceivablesAndOtherSecuritiesContoller,
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
                    title: "Hutang pribadi yang jatuh tempo tahun ini",
                    inputType: TextInputType.number,
                    controller: _personalDebtDueThisYearController,
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
                    context.read<ZakatCalculateBloc>().add(CalculatingMaal(
                          giroSavingsDepositValue: _giroSavingsDepositValueController.text,
                          vehiclePropertyValue: _vehiclePropertyValueController.text,
                          goldSilverGgemsOrOthers: _goldSilverGgemsOrOthersController.text,
                          sharesReceivablesAndOtherSecurities: _sharesReceivablesAndOtherSecuritiesContoller.text,
                          personalDebtDueThisYear: _personalDebtDueThisYearController.text,
                        ));
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
