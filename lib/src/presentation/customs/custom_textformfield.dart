import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextformField extends StatelessWidget {
  final TextEditingController cont;

  final String? isEnabled;
  final InputDecoration decoration;
  final dynamic validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int maxLine;
  const CustomTextformField({
    super.key,
    required this.cont,
    this.isEnabled,
    this.decoration = const InputDecoration(),
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      validator: validator,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      controller: cont,
      enabled: isEnabled == '1' ? false : true,
      decoration: decoration,
      inputFormatters: keyboardType == TextInputType.phone
          ? [LengthLimitingTextInputFormatter(10)]
          : [],
    );
  }
}
