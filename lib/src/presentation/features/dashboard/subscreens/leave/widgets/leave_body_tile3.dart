import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/leave/widgets/leave_listcard.dart';

class LeaveBodyTile3 extends StatelessWidget {
  const LeaveBodyTile3({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return ListView.builder(
      itemBuilder: (context, index) {
        return LeaveListCard(dark: isDark);
      },
    );
  }
}
