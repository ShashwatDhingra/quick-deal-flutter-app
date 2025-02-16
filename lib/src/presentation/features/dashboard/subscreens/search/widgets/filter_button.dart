
  import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

Widget buildFilterButton({IconData? icon, String? text}) {
    return GestureDetector(
      onTap: () {},
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
                if (icon != null) Icon(icon),
                if (text != null) Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }

