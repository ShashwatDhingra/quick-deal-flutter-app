import 'package:flutter/material.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

import '../../../core/router/routes.dart';
import '../../customs/custom_icon_button.dart';
import '../dashboard/subscreens/home/home_screen.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lead"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomIconButton(
              width: 50.w,
              height: 50.h,
              assetSt: "",
              onTap: () {
                context.pushNamed(Routes.createLeadFormScreen);
              },
              defaultIcon: Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
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
            )
          ],
        ),
      ),
    );
  }
}
