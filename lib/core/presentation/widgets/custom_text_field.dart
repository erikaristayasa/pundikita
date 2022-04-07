import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/extensions.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String placeholder;
  final bool isSecure;
  final bool isError;
  final TextEditingController controller;
  final FormFieldValidator fieldValidator;
  final TextInputType inputType;
  final bool refresh;
  final Function? onTap;
  final String? suffixText;
  final bool border;
  final void Function(String value)? onChanged;
  final bool enabled;
  const CustomTextField({
    Key? key,
    this.placeholder = '',
    this.title,
    this.isSecure = false,
    this.isError = false,
    required this.controller,
    required this.fieldValidator,
    this.inputType = TextInputType.text,
    this.refresh = false,
    this.onTap,
    this.suffixText,
    this.border = false,
    this.onChanged,
    this.enabled = true,
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
          onTap: () {
            if (widget.refresh) {
              widget.onTap!();
            }
          },
          onChanged: widget.onChanged,
          obscureText: _passwordVisible,
          controller: widget.controller,
          keyboardType: widget.inputType,
          style: TextStyle(
            color: widget.isError ? Colors.white : Colors.black,
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
            fillColor: widget.isError ? Colors.red : Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
          validator: widget.fieldValidator,
        ),
      ],
    );
  }
}
