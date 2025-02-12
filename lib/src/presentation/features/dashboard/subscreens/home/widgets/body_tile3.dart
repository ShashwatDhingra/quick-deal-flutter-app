import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/home/widgets/body_tile2.dart';

import '../../../../../customs/see_all.dart';

class BodyTile3 extends StatelessWidget {
  const BodyTile3({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    return 
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Column(
        // margin: const EdgeInsets.all(12),
        // padding: const EdgeInsets.all(5.0),
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
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 12.h,
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SinglePropertyCard(
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
                itemCount: 3),
          )
        ],
      ),
    );
  
  
  }
}
