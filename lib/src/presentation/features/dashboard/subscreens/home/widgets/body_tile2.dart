import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../customs/see_all.dart';
import '../home_screen.dart';

/// **2nd Tile - Horizontally Scrollable**
class BodyTile2 extends ConsumerWidget {
  const BodyTile2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New Properties",
                style: TextStyle(fontSize: 19.sp),
              ),
              seeAll(
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 150.h, // ListView ke liye fixed height
            width: double.infinity,

            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 400,
                      child: SinglePropertyCard(
                        imageUrl:
                            "https://i.pinimg.com/736x/b2/9e/97/b29e9776d0c4448aab9d4df1a0962a43.jpg",
                        title: "Luxury Apartment",
                        type: "Rent",
                        location: "456 Elm St, Town",
                        bedrooms: 3,
                        bathrooms: 2,
                        area: 150,
                        price: "3000",
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
