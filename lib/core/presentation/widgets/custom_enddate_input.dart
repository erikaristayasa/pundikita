import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../static/extensions.dart';
import '../../utility/helper.dart';
import '../../utility/locator.dart';
import '../../utility/validation_helper.dart';
import '../blocs/text_controller/text_controller_bloc.dart';

class CustomEndDateInput extends StatelessWidget {
  final String? title;
  final TextEditingController controller;
  final DateTime? date;

  const CustomEndDateInput({Key? key, required this.controller, this.date, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const normalBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    );

    const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    );
    _showDatePicker(DateTime? date) async {
      final now = DateTime.now();
      final lastDate = now.add(const Duration(days: 60));
      await showDatePicker(context: context, initialDate: date ?? now, firstDate: now, lastDate: lastDate).then(
        (value) {
          if (value != null) {
            controller.text = value.toText();
          }
        },
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<TextControllerBloc>(),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'Tanggal Lahir',
            style: context.textTheme().titleSmall,
          ),
          smallVerticalSpacing(),
          BlocBuilder<TextControllerBloc, TextControllerState>(
            builder: (context, state) {
              final bloc = context.read<TextControllerBloc>();
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                        enabled: false,
                        controller: controller,
                        style: context.textTheme().bodyMedium,
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          border: InputBorder.none,
                          hintText: title,
                          enabledBorder: normalBorder,
                          disabledBorder: normalBorder,
                          focusedBorder: normalBorder,
                          errorBorder: errorBorder,
                          focusedErrorBorder: errorBorder,
                          filled: true,
                          fillColor: state.error ? Colors.red : Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        validator: ValidationHelper(
                          isError: (error) => bloc.add(TextControllerOnError(error)),
                          typeField: TypeField.none,
                        ).validate()),
                  ),
                  IconButton(
                    onPressed: () => _showDatePicker(date),
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
