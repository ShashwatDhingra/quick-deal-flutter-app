import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';

class CustomTextformField extends StatelessWidget {
  final TextEditingController cont;
  final bool? isEnabled;
  final InputDecoration decoration;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int maxLines;
  final int minLines;
  final String? labelText;
  final void Function(String)?  onChanged;

  const CustomTextformField(
      {super.key,
      required this.cont,
      this.isEnabled,
      this.decoration = const InputDecoration(),
      this.obscureText = false,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.minLines = 1,
      this.labelText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: (keyboardType == TextInputType.emailAddress)
          ? emailValidator
          : (keyboardType == TextInputType.visiblePassword)
              ? passwordValidator
              : validator,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      controller: cont,
      enabled: isEnabled ?? true,
      decoration: decoration.copyWith(
        alignLabelWithHint: true,
        label: labelText == null ? null : Text(labelText!),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: CColors.primary,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
      inputFormatters: keyboardType == TextInputType.phone
          ? [LengthLimitingTextInputFormatter(10)]
          : keyboardType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
    );
  }
}

String? emailValidator(String? value) {
  // Check if the email is empty
  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  }

  // Regular expression for validating an email
  String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regExp = RegExp(emailPattern);

  if (!regExp.hasMatch(value)) {
    return 'Please enter a valid email address';
  }

  return null; // Return null if validation is successful
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  return null;
}
