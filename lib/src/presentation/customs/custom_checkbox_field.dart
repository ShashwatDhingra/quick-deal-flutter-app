import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

class CustomCheckboxField extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String labelText;
  final bool isEnabled;

  const CustomCheckboxField({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = "Enable Feature",
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? () => onChanged(!value) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isEnabled ? CColors.primary : Colors.grey,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: TextStyle(
                fontSize: 16.sp,
                color: isEnabled ? Colors.black : Colors.grey,
              ),
            ),
            Checkbox(
              value: value,
              onChanged: isEnabled ? onChanged : null,
              activeColor: CColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
