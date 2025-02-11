

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
          child: CircleAvatar(
            backgroundColor: isDark ? CColors.darkContainer : CColors.primary,
            child: Icon(
              Icons.person,
              size: 26.sp,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: isDark ? CColors.textWhite : Colors.black)),
            Text(
              'Software Development',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: isDark ? CColors.darkGrey : CColors.primary),
            )
          ],
        ),
        actions: [
          const CustomIconButton(
            assetSt: AssetsConsts.icNotification,
          ),
          12.pw,
          const CustomIconButton(assetSt: AssetsConsts.icMessage),
          12.pw,
        ],
      ),
      body: const Column(
        children: [
          Expanded(flex: 1, child: BodyTile1()),
          Expanded(flex: 2, child: BodyTile2()),
          Expanded(flex: 2, child: BodyTile3())
        ],
      ),
    );
  }
}
