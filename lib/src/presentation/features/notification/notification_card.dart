import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';


class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Icon(
                    Icons.edit_document,
                    size: 50.sp,
                  ),
                )),
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.justify,
                    )
                  ],
                ))
          ],
        )
      ],
    );
  }
}
