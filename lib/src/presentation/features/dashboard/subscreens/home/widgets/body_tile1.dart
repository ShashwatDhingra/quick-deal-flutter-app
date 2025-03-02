import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../customs/custom_icon_button.dart';

/// **1st Tile - Horizontally Scrollable**
// ignore: must_be_immutable
class BodyTile1 extends StatelessWidget {
  BodyTile1({super.key});
  List<Map<String, dynamic>> propertyTypes = [
    {"name": "Commercial", "icon": Icons.business},
    {"name": "Office", "icon": Icons.work},
    {"name": "Shop", "icon": Icons.store},
    {"name": "Residential", "icon": Icons.home},
    {"name": "Apartment", "icon": Icons.apartment},
    {
      "name": "Studio",
      "icon": Icons.apartment
    }, // Assuming studio is similar to apartment
    {"name": "Villa", "icon": Icons.villa}, // Assuming you have a villa icon
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 10.w,
        left: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What are you looking for",
            style: TextStyle(fontSize: 19.sp),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 80.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 15.w),
              itemCount: propertyTypes.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CustomIconButton(
                      width: 60.w,
                      height: 60.h,
                      assetSt: "",
                      defaultIcon: propertyTypes[index]['icon'],
                    ),
                    Text(propertyTypes[index]['name']),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
