import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../../customs/see_all.dart';
import '../../../states/home_state.dart';

class BodyTile2 extends ConsumerWidget {
  const BodyTile2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final homeState = ref.watch(homeStateProvider);
    // final homeStateNotifier = ref.read(homeStateProvider.notifier);
    // var isDark = context.isDarkMode;
    return Padding(
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
                    width: 12.w,
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const SinglePropertyCard(
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
                itemCount: 1),
          )
        ],
      ),
    );
  }
}

class SinglePropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String type;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final String price;

  const SinglePropertyCard({
    super.key,
    this.imageUrl =
        "https://i.pinimg.com/736x/b2/9e/97/b29e9776d0c4448aab9d4df1a0962a43.jpg",
    this.title = "Villa the Pool",
    this.type = "Sale",
    this.location = "123 Main St, City",
    this.bedrooms = 4,
    this.bathrooms = 4,
    this.area = 125,
    this.price = "490000",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures it takes the full available width
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff565992).withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          SizedBox(
            width: 120, // Set fixed width for image
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12), // Add spacing between image and text

          // Property Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                Text(
                  type,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: Colors.blue, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Bedrooms, Bathrooms, Area
                Row(
                  children: [
                    _buildIconText(Icons.bed_rounded, bedrooms.toString()),
                    _buildIconText(
                        Icons.bathtub_outlined, bathrooms.toString()),
                    _buildIconText(Icons.aspect_ratio_sharp, "$area SQ Ft"),
                  ],
                ),
                const SizedBox(height: 8),

                // Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Price",
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 16),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 8),
      ],
    );
  }
}
