import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';

class CustomDropdownField extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?> onChanged;
  final String? labelText;
  final bool isEnabled;

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<bool>(
      value: value,
      onChanged: isEnabled ? onChanged : null,
      items: const [
        DropdownMenuItem(
          value: true,
          child: Text("Yes"),
        ),
        DropdownMenuItem(
          value: false,
          child: Text("No"),
        ),
      ],
      decoration: InputDecoration(
        label: labelText == null ? null : Text(labelText!),
        alignLabelWithHint: true,
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
