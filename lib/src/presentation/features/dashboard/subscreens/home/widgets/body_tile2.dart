

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../states/home_state.dart';

class BodyTile2 extends ConsumerWidget {
  const BodyTile2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStateProvider);
    final homeStateNotifier = ref.read(homeStateProvider.notifier);
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
                    Row(
                      children: [
                        Text('Today Appointment',
                            style: Theme.of(context).textTheme.titleLarge),
                        6.pw,
                        if (homeState.appointmentList.isNotEmpty)
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: isDark
                                    ? CColors.darkContainer
                                    : CColors.primary.withOpacity(0.1),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              child: Text(
                                  homeState.appointmentList.length.toString())),
                      ],
                    ),
                    Text('Your Schedule for the day',
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    homeStateNotifier.fetchAppointmentList();
                  },
                ),
              ],
            ),
            homeState.isAppointmentListLoading
                ? Expanded(
                    child: Center(
                      child: SizedBox(
                          height: 30.h,
                          width: 30.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 1,
                          )),
                    ),
                  )
                : homeState.appointmentList.isEmpty
                    ? const Expanded(child: _EmptyTileWidget())
                    : Expanded(child: _ListTileWidget(homeState: homeState))
          ],
        ));
  }
}

class _EmptyTileWidget extends StatelessWidget {
  const _EmptyTileWidget();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
        child: Text('No Meeting Available',
            style: Theme.of(context).textTheme.titleLarge),
      ),
      Expanded(
        child: Center(
          child: Text(
            'It looks like you don’t have any meetings scheduled at the moment.',
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ]);
  }
}

class _ListTileWidget extends StatelessWidget {
  const _ListTileWidget({required this.homeState});
  final HomeState homeState;

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;

    return ListView.separated(
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 87.w),
            child: Divider(
              color: Colors.grey.shade400,
            ),
          );
        },
        itemCount: homeState.appointmentList.length,
        itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(14.0),
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.07),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(homeState.appointmentList[index]["name"].toString(),
                          style: Theme.of(context).textTheme.headlineSmall),
                      const Spacer(),
                      ImageIcon(
                        const AssetImage(
                          AssetsConsts.icClock,
                        ),
                        color: Colors.grey.withOpacity(0.4),
                        size: 18,
                      ),
                      8.pw,
                      Text(homeState.appointmentList[index]['in_time'] + ' - '),
                      Text(homeState.appointmentList[index]['out_time'])
                    ],
                  ),
                  8.ph,
                  Container(
                      width: 70.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          color:
                              isDark ? CColors.darkContainer : CColors.primary,
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                          child: Text('Start',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white))))
                ],
              ),
            ));
  }
}
