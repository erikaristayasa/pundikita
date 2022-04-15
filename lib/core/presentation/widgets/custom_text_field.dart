import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../static/extensions.dart';
import '../../utility/locator.dart';
import '../../utility/validation_helper.dart';
import '../blocs/text_controller/text_controller_bloc.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String placeholder;
  final bool isSecure;
  final TextEditingController controller;
  final TextEditingController? controllerMatcher;
  final TextInputType inputType;
  final bool refresh;
  final Function? onTap;
  final String? suffixText;
  final String? prefixText;
  final bool border;
  final bool enabled;
  final TypeField typeField;
  final String valueMatcher;
  final Function(String value)? onChange;
  final List<TextInputFormatter>? formatters;
  const CustomTextField({
    Key? key,
    this.placeholder = '',
    this.title,
    this.isSecure = false,
    required this.controller,
    this.inputType = TextInputType.text,
    this.refresh = false,
    this.onTap,
    this.suffixText,
    this.border = false,
    this.enabled = true,
    this.typeField = TypeField.none,
    this.valueMatcher = '',
    this.controllerMatcher,
    this.prefixText,
    this.onChange,
    this.formatters,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _passwordVisible;

  late OutlineInputBorder normalBorder;

  late OutlineInputBorder errorBorder;

  @override
  void initState() {
    _passwordVisible = widget.isSecure;
    normalBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: widget.border ? Colors.grey : Colors.white,
      ),
    );
    errorBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<TextControllerBloc>(),
      child: BlocBuilder<TextControllerBloc, TextControllerState>(
        builder: (context, state) {
          final bloc = context.read<TextControllerBloc>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.title != null
                  ? Text(
                      widget.title ?? "",
                      style: context.textTheme().titleSmall,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 4.0),
              TextFormField(
                enabled: widget.enabled,
                inputFormatters: widget.formatters,
                onTap: () {
                  if (widget.refresh) {
                    widget.onTap!();
                  }
                },
                onChanged: widget.onChange, //bloc.add(TextControllerOnChanged(newValue: newValue)),
                obscureText: _passwordVisible,
                controller: widget.controller,
                keyboardType: widget.inputType,
                style: TextStyle(
                  color: state.error ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  hintText: widget.placeholder,
                  border: InputBorder.none,
                  enabledBorder: normalBorder,
                  disabledBorder: normalBorder,
                  focusedBorder: normalBorder,
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                  filled: true,
                  fillColor: state.error ? Colors.red : Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  prefixIcon: widget.prefixText != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.prefixText ?? '',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : null,
                  suffixIcon: widget.isSecure
                      ? Material(
                          color: Colors.transparent,
                          child: IconButton(
                              splashRadius: 20.0,
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              icon: Icon(_passwordVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded)),
                        )
                      : widget.suffixText != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.suffixText!, textAlign: TextAlign.center, style: context.textTheme().labelSmall),
                              ],
                            )
                          : null,
                ),
                validator: ValidationHelper(
                  valueMatcher: widget.controllerMatcher?.text,
                  isError: (error) => bloc.add(TextControllerOnError(error)),
                  typeField: widget.typeField,
                ).validate(),
              ),
            ],
          );
        },
      ),
    );
  }
}
