import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../customs/custom_icon_button.dart';
import 'widgets/body_tile1.dart';
import 'widgets/body_tile2.dart';
import 'widgets/body_tile3.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: isDark ? CColors.dark : CColors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.3),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: Icon(
              Icons.menu,
              size: 24.sp,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('  Current Location',
                style: TextStyle(
                    color: isDark ? CColors.textWhite : Colors.black,
                    fontSize: 12.sp)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined),
                Text(
                  'Delhi',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: isDark ? CColors.light : CColors.black),
                )
              ],
            )
          ],
        ),
        actions: [
          const CustomIconButton(
            assetSt: AssetsConsts.icNotification,
          ),
          12.pw,
        ],
      ),
      body: const Column(
        children: [
          Expanded(flex: 4, child: BodyTile1()),
          Expanded(flex: 4, child: BodyTile2()),
          Expanded(flex: 6, child: BodyTile3())
        ],
      ),
    );
  }
}
