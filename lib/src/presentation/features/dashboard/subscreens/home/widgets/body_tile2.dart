import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/dashboard/states/home_state.dart';

import '../../../../../../core/router/routes.dart';
import '../../../../../customs/custom_single_property_card.dart';
import '../../../../../customs/see_all.dart';

/// **2nd Tile - Horizontally Scrollable**
class BodyTile2 extends ConsumerWidget {
  const BodyTile2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStateProvider);
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
            child: homeState.bodyTile2Loading
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: homeState.propertyList.length,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: 400, child: SinglePropertyCardShimmer()),
                      );
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: homeState.propertyList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: 400,
                            child: SinglePropertyCard(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.propertyDetailScreen,
                                    arguments: homeState.propertyList[index]);
                              },
                              imageUrl:
                                  "https://i.pinimg.com/736x/b2/9e/97/b29e9776d0c4448aab9d4df1a0962a43.jpg",
                              title: homeState.propertyList[index].title,
                              type:
                                  homeState.propertyList[index].propertyType ??
                                      '',
                              location:
                                  homeState.propertyList[index].area ?? '',
                              bedrooms:
                                  homeState.propertyList[index].bedrooms ?? 0,
                              bathrooms:
                                  homeState.propertyList[index].bathrooms ?? 0,
                              area: double.tryParse(
                                  homeState.propertyList[index].area ?? ''),
                              price: homeState.propertyList[index].price
                                  .toString(),
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
