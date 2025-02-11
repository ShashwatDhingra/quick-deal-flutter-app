
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../core/utils/ui_utils/constants/colors.dart';
import 'widgets/leave_body_tile1.dart';
import 'widgets/leave_body_tile2.dart';
import 'widgets/leave_body_tile3.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = context.isDarkMode;
    return Scaffold(
      backgroundColor: dark ? Colors.transparent : CColors.softGrey,
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(flex: 3, child: LeaveBodyTile1()),
            Expanded(flex: 1, child: LeaveBodyTile2()),
            Expanded(flex: 5, child: LeaveBodyTile3()),
          ],
        ),
      ),
    );
  }
}
