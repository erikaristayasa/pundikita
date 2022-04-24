import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/extensions.dart';

class CustomTextArea extends StatefulWidget {
  final String title;
  final String placeholder;
  final bool isError;
  final TextEditingController controller;
  final FormFieldValidator fieldValidator;
  final TextInputType inputType;
  final void Function(String value)? onChanged;
  const CustomTextArea({
    Key? key,
    required this.title,
    this.placeholder = '',
    this.isError = false,
    required this.controller,
    required this.fieldValidator,
    this.inputType = TextInputType.multiline,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  final normalBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: Colors.white,
    ),
  );

  final errorBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: Colors.red,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: context.textTheme().titleSmall,
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          obscureText: false,
          controller: widget.controller,
          keyboardType: widget.inputType,
          maxLines: 8,
          style: TextStyle(
            color: widget.isError ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            focusColor: Colors.white,
            hintText: widget.placeholder,
            border: InputBorder.none,
            enabledBorder: normalBorder,
            focusedBorder: normalBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            filled: true,
            fillColor: widget.isError ? Colors.red : Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          validator: widget.fieldValidator,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
