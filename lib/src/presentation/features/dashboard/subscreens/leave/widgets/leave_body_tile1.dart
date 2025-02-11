import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../../core/utils/ui_utils/constants/colors.dart';

class LeaveBodyTile1 extends StatelessWidget {
  const LeaveBodyTile1({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = context.isDarkMode;
    return Stack(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                          color: dark ? CColors.darkContainer : CColors.primary,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                    )),
                Expanded(flex: 2, child: Container()),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.w, left: 16.w),
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
                                  "Leave Summmery",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(color: CColors.white),
                                ),
                                const Text(
                                  "Sumbit Leave",
                                  style: TextStyle(color: CColors.grey),
                                )
                              ],
                            ),
                            Image.asset(
                              AssetsConsts.leaveBagIllus,
                              height: 64.h,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(right: 16.w),
                          padding: const EdgeInsets.all(12.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: dark
                                        ? CColors.darkContainer
                                            .withOpacity(0.05)
                                        : const Color(0xff565992)
                                            .withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 0)
                              ],
                              color: dark ? CColors.darkerGrey : Colors.white,
                              borderRadius: BorderRadius.circular(14.0),
                              border: Border.all(
                                  color: dark
                                      ? CColors.darkerGrey
                                      : CColors.grey)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Total Leave',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                    const Text(
                                        'Period 1 Jan 2024 - 30 Dec 2024')
                                  ],
                                ),
                              ),
                              6.ph,
                              Expanded(
                                flex: 2,
                                child: Row(children: [
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
                                          color: dark
                                              ? CColors.grey.withOpacity(0.3)
                                              : CColors.grey),
                                      boxShadow: [
                                        BoxShadow(
                                            color: dark
                                                ? CColors.darkContainer
                                                    .withOpacity(0.05)
                                                : const Color(0xffffffff)
                                                    .withOpacity(0.1),
                                            blurRadius: 10,
                                            spreadRadius: 0)
                                      ],

                                      // color: Colors.white.withOpacity(0.1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(children: [
                                            Image.asset(
                                              AssetsConsts.icDot,
                                              height: 16.h,
                                              color: Colors.green,
                                            ),
                                            4.pw,
                                            Text('Available',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall)
                                          ]),
                                        ),
                                        6.ph,
                                        Expanded(
                                          child: Text(
                                            '20',
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
                                        boxShadow: [
                                          BoxShadow(
                                              color: dark
                                                  ? CColors.darkContainer
                                                      .withOpacity(0.05)
                                                  : const Color(0xffffffff)
                                                      .withOpacity(0.1),
                                              blurRadius: 10,
                                              spreadRadius: 0)
                                        ],
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                        border: Border.all(
                                            color: dark
                                                ? CColors.grey.withOpacity(0.3)
                                                : CColors.grey)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(children: [
                                            Image.asset(
                                              AssetsConsts.icDot,
                                              height: 16.h,
                                              color: CColors.primary,
                                            ),
                                            4.pw,
                                            Text('Leave Used',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall)
                                          ]),
                                        ),
                                        6.ph,
                                        Expanded(
                                          child: Text(
                                            '17',
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
