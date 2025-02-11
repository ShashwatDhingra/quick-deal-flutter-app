import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../../customs/custom_elevated_button.dart';

class AttendanceBodyTile1 extends StatelessWidget {
  const AttendanceBodyTile1({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    return Stack(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(22.w),
                      decoration: BoxDecoration(
                          color:
                              isDark ? CColors.darkContainer : CColors.primary,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                    )),
                Expanded(flex: 2, child: Container()),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Let's Clock In",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(color: CColors.white),
                                ),
                                const Text(
                                  "Don’t miss your clock in schedule",
                                  style: TextStyle(color: CColors.grey),
                                )
                              ],
                            ),
                            Image.asset(
                              AssetsConsts.clockIllus,
                              height: 64.sp,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: isDark ? CColors.darkerGrey : Colors.white,
                              borderRadius: BorderRadius.circular(14.0),
                              border: Border.all(
                                  color: isDark ? CColors.dark : CColors.grey)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('Total Working Hour',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ),
                              6.ph,
                              Expanded(
                                flex: 3,
                                child: Row(children: [
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                        border: Border.all(
                                            color: isDark
                                                ? CColors.darkContainer
                                                : CColors.grey)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(children: [
                                            Image.asset(
                                              AssetsConsts.icClock,
                                              height: 16.h,
                                            ),
                                            4.pw,
                                            Text('Check-In',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall)
                                          ]),
                                        ),
                                        6.ph,
                                        Expanded(
                                          child: Text(
                                            '10:00 AM',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                  12.pw,
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                        border: Border.all(
                                            color: isDark
                                                ? CColors.darkContainer
                                                : CColors.grey)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(children: [
                                            Image.asset(
                                              AssetsConsts.icClock,
                                              height: 16.h,
                                            ),
                                            4.pw,
                                            Text('Check-Out',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall)
                                          ]),
                                        ),
                                        6.ph,
                                        Expanded(
                                          child: Text(
                                            '5:00 PM',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                ]),
                              ),
                              12.ph,
                              Expanded(
                                  flex: 2,
                                  child: MElevatedButton(
                                      text: 'Clock-In Now', onPress: () {}))
                            ],
                          ),
                          // child: ,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
