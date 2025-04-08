import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../core/utils/ui_utils/constants/colors.dart';

class SinglePropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String type;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final double? area;
  final String price;
  final void Function()? onTap;
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
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isDark ? CColors.darkContainer : CColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: CColors.black.withOpacity(0.2),
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
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:  TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                    _buildIconText(
                        Icons.bathtub_outlined, bathrooms.toString()),
                    _buildIconText(Icons.aspect_ratio_sharp, "${area ?? '--'} SQ Ft"),
                  ]),
                  const SizedBox(height: 8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Price",
                            style: TextStyle(fontSize: 12, color: Colors.blue)),
                        Text(price,
                            style:  TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      ]),
                ],
              ),
            ),
          ],
        ),
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
