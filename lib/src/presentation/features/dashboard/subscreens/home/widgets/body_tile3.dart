
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../../core/utils/ui_utils/constants/colors.dart';

class BodyTile3 extends StatelessWidget {
  const BodyTile3({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isDark ? CColors.darkContainer : CColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today Task',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('The tasks assigned to you for today',
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.refresh),
              ],
            ),
            16.ph,
            Center(
              child: Column(
                children: [
                  Image.asset(
                    AssetsConsts.emptyAppointmentIllus,
                    height: 77.h,
                  )
                ],
              ),
            ),
            12.ph,
            Center(
              child: Text('No Tasks Assigned',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'It looks like you don’t have any tasks assigned to you right now.',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ));
  }
}
