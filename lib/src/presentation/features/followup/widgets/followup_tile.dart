import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../core/utils/ui_utils/constants/sizes.dart';

class FollowupTile extends StatelessWidget {
  const FollowupTile({
    super.key,
    required this.isDark,
    required this.name,
    required this.phone,
    required this.completed,
  });

  final bool isDark;
  final String name;
  final String phone;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? CColors.grey.withOpacity(0.1) : CColors.white,
        borderRadius: BorderRadius.circular(10.sp),
        boxShadow: [
          BoxShadow(
            color: isDark ? CColors.darkerGrey.withOpacity(0.2) : CColors.grey,
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  completed ? 'Open' : 'Pending',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: Sizes.xl,
            ),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: CColors.success,
                ),
                const SizedBox(
                  width: Sizes.sm,
                ),
                Text(
                  phone,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            12.hBox,
            Row(
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: CColors.info,
                ),
                const SizedBox(
                  width: Sizes.sm,
                ),
                Expanded(
                  child: Text(
                    "ajju@extensioncrm.com",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(overflow: TextOverflow.ellipsis),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
