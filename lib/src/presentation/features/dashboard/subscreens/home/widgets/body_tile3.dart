import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../customs/see_all.dart';

/// **3rd Tile - Vertically Scrollable**
class BodyTile3 extends StatelessWidget {
  const BodyTile3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
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
          SizedBox(height: 10.h),
          ListView.separated(
            physics:
                const NeverScrollableScrollPhysics(), // Parent ke saath scroll hoga
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemCount: 5,
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
          ),
        ],
      ),
    );
  }
}

/// **Property Card**
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
    required this.imageUrl,
    required this.title,
    required this.type,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(type,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on_outlined,
                      color: Colors.blue, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                      child: Text(location,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis)),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  _buildIconText(Icons.bed_rounded, bedrooms.toString()),
                  _buildIconText(Icons.bathtub_outlined, bathrooms.toString()),
                  _buildIconText(Icons.aspect_ratio_sharp, "$area SQ Ft"),
                ]),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Price",
                          style: TextStyle(fontSize: 12, color: Colors.blue)),
                      Text(price,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(children: [
      Icon(icon, color: Colors.blue, size: 16),
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(fontSize: 12)),
      const SizedBox(width: 8)
    ]);
  }
}
