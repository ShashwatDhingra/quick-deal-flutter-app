
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/dashboard/states/attendance_state.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/attendance/widget/attendance_listcard.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';

class AttendanceBodyTile2 extends ConsumerWidget {
  const AttendanceBodyTile2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDarkMode;
    final attendanceState = ref.watch(attendanceStateProvider);
    final attendanceStateNotifier = ref.read(attendanceStateProvider.notifier);
    return attendanceState.attendanceList.isEmpty
        ? Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: isDark
                          ? CColors.darkContainer.withOpacity(0.05)
                          : const Color(0xff565992).withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 0)
                ],
                color: isDark ? CColors.darkContainer : CColors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Working Period',
                              style: Theme.of(context).textTheme.titleLarge),
                          Text('Your working time in this paid period',
                              style: Theme.of(context).textTheme.labelSmall),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            attendanceStateNotifier.fetchAttendanceList();
                          },
                          child: const Icon(Icons.refresh)),
                    ],
                  ),
                ),
                16.ph,
                attendanceState.isAttendanceListLoading
                    ? const Expanded(
                        flex: 2,
                        child: Center(
                          child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              )),
                        ),
                      )
                    : Expanded(
                        flex: 2,
                        child: Column(children: [
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
                            child: Text('No Working Time Available',
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          Center(
                            child: Text(
                              'It looks like you don’t have any working time in this period.',
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                      ),
              ],
            ))
        : ListView.builder(
            itemBuilder: (context, index) {
              return AttendanceListCard(dark: isDark);
            },
          );
  }
}
