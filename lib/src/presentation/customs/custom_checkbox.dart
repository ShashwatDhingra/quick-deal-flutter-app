import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../core/utils/ui_utils/constants/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final double size;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    // final uncheckedColor = Theme.of(context).scaffoldBackgroundColor;
    final dark =context.isDarkMode;
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: CColors.borderPrimary),
          color: dark ? CColors.black : CColors.white,
          borderRadius: BorderRadius.circular(
            4.0,
          ),
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                color: dark ? CColors.white : CColors.textthird,
                size: size * 0.8,
              )
            : null,
      ),
    );
  }
}

class CustomCheckboxExample extends StatefulWidget {
  const CustomCheckboxExample({super.key});

  @override
  CustomCheckboxExampleState createState() => CustomCheckboxExampleState();
}

class CustomCheckboxExampleState extends State<CustomCheckboxExample> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomCheckbox(
          isChecked: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          size: 30.0,
        ),
      ],
    );
  }
}
