import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';

class IncrementDecrementField extends StatefulWidget {
  final TextEditingController controller;
  final int minValue;
  final int maxValue;
  final int step;
  final String? labelText;
  final bool isEnabled;

  const IncrementDecrementField({
    super.key,
    required this.controller,
    this.minValue = 0,
    this.maxValue = 100,
    this.step = 1,
    this.labelText,
    this.isEnabled = true,
  });

  @override
  _IncrementDecrementFieldState createState() => _IncrementDecrementFieldState();
}

class _IncrementDecrementFieldState extends State<IncrementDecrementField> {
  void _increment() {
    int currentValue = int.tryParse(widget.controller.text) ?? widget.minValue;
    if (currentValue + widget.step <= widget.maxValue) {
      widget.controller.text = (currentValue + widget.step).toString();
    }
  }

  void _decrement() {
    int currentValue = int.tryParse(widget.controller.text) ?? widget.minValue;
    if (currentValue - widget.step >= widget.minValue) {
      widget.controller.text = (currentValue - widget.step).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      enabled: widget.isEnabled,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        label: widget.labelText == null ? null : Text(widget.labelText!),
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
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: widget.isEnabled ? _decrement : null,
              icon: const Icon(Icons.remove),
            ),
            IconButton(
              onPressed: widget.isEnabled ? _increment : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
