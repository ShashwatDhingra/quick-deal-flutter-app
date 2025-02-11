import 'package:flutter/material.dart';

import '../../../../../customs/custom_tabbar.dart';

class ExpenseBodyTile2 extends StatelessWidget {
  const ExpenseBodyTile2({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTabbar(
      noOfTab: 3,
      selectedTab: 0,
      tabs: const ['Approved', 'Rejected', 'Complete'],
      listLengths: const [3, 2, 2],
    );
  }
}
