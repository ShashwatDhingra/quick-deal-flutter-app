import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/router/routes.dart';
import '../../../../../customs/see_all.dart';
import '../home_screen.dart';

/// **3rd Tile - Vertically Scrollable**
class BodyTile3 extends StatelessWidget {
  const BodyTile3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommended",
                style: TextStyle(fontSize: 19.sp),
              ),
              seeAll(
                onPressed: () {},
              ),
            ],
          ),
          ListView.separated(
            physics:
                const NeverScrollableScrollPhysics(), // Parent ke saath scroll hoga
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemCount: 5,
            itemBuilder: (context, index) {
              return SinglePropertyCard(
                onTap: () {
                  Navigator.pushNamed(context, Routes.propertyDetailScreen);
                },
                imageUrl:
                    "https://i.pinimg.com/736x/b2/9e/97/b29e9776d0c4448aab9d4df1a0962a43.jpg",
                title: "Luxury Apartment",
                type: "Rent",
                location: "456 Elm St, Town",
                bedrooms: 3,
                bathrooms: 2,
                area: 150,
                price: "3000",
              );
            },
          ),
        ],
      ),
    );
  }
}
