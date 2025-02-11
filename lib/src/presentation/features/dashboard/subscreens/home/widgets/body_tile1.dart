
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';

class BodyTile1 extends StatelessWidget {
  const BodyTile1({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(left: 18.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDark ? CColors.darkContainer : CColors.secondary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('My Work Summary',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              Text('Today task & presence activity',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
            ],
          ),
          Image.asset(
            AssetsConsts.cameraIllus,
            height: 77.h,
          )
        ],
      ),
    );
  }
}
