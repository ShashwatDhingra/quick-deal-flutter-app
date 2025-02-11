import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../../customs/custom_icon_button.dart';

class AttendanceListCard extends StatelessWidget {
  const AttendanceListCard({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: dark ? CColors.darkContainer : CColors.white,
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Row(children: [
            const CustomIconButton(
              assetSt: AssetsConsts.icCalendar,
              // transparentBackground: true,
            ),
            Text(
              ' 27 September 2024',
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ]),
          12.ph,
          Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: dark ? CColors.darkContainer : CColors.lightGrey,
                  border: Border.all(
                      color:
                          dark ? CColors.grey.withOpacity(0.3) : CColors.grey),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Hours',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('08:00:00 hrs',
                            style: Theme.of(context).textTheme.headlineSmall)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Clock in & Out',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('09:00 AM  — 05:00 PM',
                            style: Theme.of(context).textTheme.headlineSmall)
                      ],
                    )
                  ]))
        ]));
  }
}
