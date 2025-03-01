import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

Widget buildFilterButton(
    {IconData? icon,
    String? text,
    void Function()? onTap,
    Color? iconColor = Colors.black}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.10),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 8.h),
        child: Center(
          child: Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: iconColor,
                ),
              if (text != null) Text(" $text"),
            ],
          ),
        ),
      ),
    ),
  );
}
