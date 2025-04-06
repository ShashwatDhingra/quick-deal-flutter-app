import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/ui_utils/constants/text_strings.dart';

// ignore: must_be_immutable
class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({
    super.key,
    required this.getValue,
    required this.dateController,
    this.minimumDate,
    this.maximumDate,
    this.showTime = false,
  }) {
    // Assign default values if null
    minimumDate ??= DateTime(1900);
    maximumDate ??= DateTime.now();
  }

  final TextEditingController dateController;
  final Function(String)? getValue;
  final bool showTime;
  DateTime? minimumDate;
  DateTime? maximumDate;

  @override
  State<StatefulWidget> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  Future<void> _showCupertinoDateTimePicker(BuildContext context) async {
    var dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Ensure initialDateTime is within range
    DateTime now = DateTime.now();
    DateTime initialDateTime = now.isBefore(widget.maximumDate!)
        ? now
        : widget.maximumDate!;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        color: dark ? Colors.grey.shade900 : Colors.white,
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: widget.showTime
                    ? CupertinoDatePickerMode.dateAndTime
                    : CupertinoDatePickerMode.date,
                initialDateTime: initialDateTime,
                minimumDate: widget.minimumDate,
                maximumDate: widget.maximumDate,
                use24hFormat: true,
                onDateTimeChanged: (DateTime value) {
                  String formattedDate = widget.showTime
                      ? DateFormat("yyyy-MM-dd HH:mm:ss").format(value)
                      : DateFormat("yyyy-MM-dd").format(value);

                  widget.dateController.text = formattedDate;
                  widget.getValue?.call(formattedDate);
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CupertinoButton(
                  color: dark ? Colors.grey.shade800 : Colors.blue,
                  onPressed: () => Navigator.pop(context),
                  child: const Text(Texts.done),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _showCupertinoDateTimePicker(context),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: dark ? Colors.grey.shade700 : Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          widget.dateController.text.isEmpty
              ? (widget.showTime ? 'Select Date & Time' : 'Select Date')
              : widget.dateController.text,
          style: TextStyle(
            color: dark ? Colors.white70 : Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
