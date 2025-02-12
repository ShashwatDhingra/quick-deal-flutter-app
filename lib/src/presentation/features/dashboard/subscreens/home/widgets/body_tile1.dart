import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../customs/custom_icon_button.dart';

class BodyTile1 extends StatelessWidget {
  const BodyTile1({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Column(
        // margin: const EdgeInsets.all(12),
        // padding: const EdgeInsets.all(5.0),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onChanged: (value) {},
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide.none),
                fillColor: Colors.grey.withOpacity(0.10),
                filled: true,
                suffixIcon: const Icon(Icons.filter_list),
                prefixIcon: const Icon(Icons.search),
                hintText: "Search ",
                hintStyle: TextStyle(fontSize: 15.sp, color: Colors.grey)),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "What are you looking for",
            style: TextStyle(fontSize: 19.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10.w,
                  );
                },
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const Column(
                    children: [
                      CustomIconButton(
                        width: 60,
                        assetSt: AssetsConsts.icNotification,
                      ),
                      Text("Rent")
                    ],
                  );
                },
                itemCount: 3),
          )
        ],
      ),
    );
  }
}
