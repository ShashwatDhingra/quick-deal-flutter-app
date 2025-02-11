import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:intl/intl.dart';

import '../../core/utils/ui_utils/constants/colors.dart';

// ignore: must_be_immutable
class CustomDatePicker extends StatefulWidget {
  CustomDatePicker(
      {super.key,
      required this.getValue,
      required this.dateController,
      DateTime? minimumDate,
      DateTime? maximumDate,
      this.showTime = false})
      : minimumDate = minimumDate ?? DateTime(1900),
        maximumDate = maximumDate ?? DateTime.now();

  final TextEditingController dateController;
  final Function(dynamic)? getValue;
  final bool showTime;
  DateTime minimumDate;
  DateTime maximumDate;

  @override
  State<StatefulWidget> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  Future<void> _showCupertinoDateTimePicker(BuildContext context) async {
    var dark = context.isDarkMode;
    // Ensure initialDateTime is within range
    DateTime selectedDateTime = DateTime.now();
    if (selectedDateTime.isBefore(widget.minimumDate)) {
      selectedDateTime = widget.minimumDate;
    } else if (selectedDateTime.isAfter(widget.maximumDate)) {
      selectedDateTime = widget.maximumDate;
    }

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.39,
        color: dark ? Colors.grey.shade900 : CColors.white,
        child: Column(
          children: [
            SizedBox(
              height: 260,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                mode: widget.showTime
                    ? CupertinoDatePickerMode.dateAndTime
                    : CupertinoDatePickerMode.date,
                minimumDate: widget.minimumDate,
                maximumDate: widget.maximumDate,
                use24hFormat: false,
                onDateTimeChanged: (DateTime value) {
                  selectedDateTime = value;
                  widget.dateController.text = widget.showTime
                      ? DateFormat(
                              "yyyy-MM-dd hh:mm:ss                                                                                     ")
                          .format(value)
                      : DateFormat("yyyy-MM-dd").format(value);
                  widget.getValue?.call(widget.dateController.text);
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: OutlinedButton(
                  onPressed: () {
                    widget.dateController.text.isEmpty
                        ? widget.dateController.text = widget.showTime
                            ? DateFormat("yyyy-MM-dd hh:mm:ss")
                                .format(DateTime.now())
                                .toString()
                            : DateFormat("yyyy-MM-dd")
                                .format(DateTime.now())
                                .toString()
                        : null;
                    setState(() {});
                   context.pop(context);
                  },
                  child: const Text("Done"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var dark =context.isDarkMode;
    return GestureDetector(
      onTap: () => _showCupertinoDateTimePicker(context),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.058,
        decoration: BoxDecoration(
          border: Border.all(color: dark ? CColors.darkGrey : CColors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.dateController.text.isEmpty
                ? widget.showTime
                    ? 'Select Date and Time'
                    : 'Select Date'
                : widget.showTime
                    ? widget.dateController.text.toString().substring(0, 16)
                    : widget.dateController.text,
            style: TextStyle(
              color: dark ? CColors.darkGrey : CColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
