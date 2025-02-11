import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/expense/widgets/expense_listcard.dart';

class ExpenseBodyTile3 extends StatelessWidget {
  const ExpenseBodyTile3({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return ListView.builder(
      itemBuilder: (context, index) {
        return ExpenseListCard(dark: isDark);
      },
    );
  }
}
