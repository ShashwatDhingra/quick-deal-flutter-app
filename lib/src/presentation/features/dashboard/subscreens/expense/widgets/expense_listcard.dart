import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../../customs/custom_icon_button.dart';

class ExpenseListCard extends StatelessWidget {
  const ExpenseListCard({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: dark
                      ? CColors.darkContainer.withOpacity(0.05)
                      : const Color(0xff565992).withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 0)
            ],
            color: dark ? CColors.darkContainer : CColors.white,
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Row(children: [
            const CustomIconButton(
              assetSt: AssetsConsts.icExpense,
              // transparentBackground: true,
            ),
            Text(
              ' 27 September 2024',
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ]),
          12.hBox,
          Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: dark ? CColors.darkContainer : CColors.lightGrey,
                  border: Border.all(
                      color:
                          dark ? CColors.grey.withOpacity(0.3) : CColors.grey),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('E-Learning',
                            style: Theme.of(context).textTheme.headlineSmall)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Expense',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('\$55',
                            style: Theme.of(context).textTheme.headlineSmall)
                      ],
                    )
                  ]))
        ]));
  }
}
