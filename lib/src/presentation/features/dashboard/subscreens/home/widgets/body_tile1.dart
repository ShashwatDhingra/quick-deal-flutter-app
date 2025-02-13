import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../customs/custom_icon_button.dart';

/// **1st Tile - Horizontally Scrollable**
class BodyTile1 extends StatelessWidget {
  const BodyTile1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What are you looking for",
            style: TextStyle(fontSize: 19.sp),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 80.h, // ListView ke liye fixed height
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Column(
                  children: [
                    CustomIconButton(
                      width: 60,
                      assetSt: AssetsConsts.icNotification,
                    ),
                    Text("Rent"),
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
