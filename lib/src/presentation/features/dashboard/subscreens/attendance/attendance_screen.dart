
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import 'widget/attendance_body_tile1.dart';
import 'widget/attendance_body_tile2.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDark = context.isDarkMode;
    return Scaffold(
      backgroundColor: isDark ? Colors.transparent : CColors.softGrey,
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(flex: 4, child: AttendanceBodyTile1()),
            Expanded(flex: 5, child: AttendanceBodyTile2()),
          ],
        ),
      ),
    );
  }
}
