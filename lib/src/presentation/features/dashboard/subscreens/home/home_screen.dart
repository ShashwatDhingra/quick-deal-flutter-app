import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/assets.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/customs/custom_icon_button.dart';
import 'package:quickdeal/src/presentation/customs/see_all.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isScrolled = false;
  double appBarHeight = 80.0; // Initial height
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;

      setState(() {
        if (offset > 50) {
          isScrolled = true;
        } else {
          isScrolled = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          /// **Animated AppBar**
          AnimatedContainer(
            duration: const Duration(milliseconds: 300), // Smooth animation
            height: appBarHeight,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: isDark ? Colors.black : Colors.white,
            child: Row(
              children: [
                /// Menu Icon
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),

                /// Location Widget (Fade out on Scroll)
                isScrolled
                    ? SizedBox()
                    : Expanded(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: 0.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '  Current Location',
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  Text(
                                    'Delhi',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black,
                                        ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                /// Search Field (Fade in on Scroll)
                Expanded(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isScrolled ? 1.0 : 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SizedBox(
                        height: isScrolled ? 31.h : 80.h,
                        child: TextFormField(
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide.none),
                              fillColor: Colors.grey.withOpacity(0.10),
                              filled: true,
                              suffixIcon: const Icon(Icons.filter_list),
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search ",
                              hintStyle: TextStyle(
                                  fontSize: isScrolled ? 12.sp : 15.sp,
                                  color: Colors.grey)),
                        ),
                      ),
                    ),
                  ),
                ),

                /// Notification Icon
                const CustomIconButton(assetSt: AssetsConsts.icNotification),
                SizedBox(width: 12.w),
              ],
            ),
          ),

          /// **Search Box (Initially Below AppBar)**
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isScrolled ? 0.0 : 1.0,
            child: isScrolled
                ? SizedBox()
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 00.h),
                    child: SizedBox(
                      height: isScrolled ? 35.h : 80.h,
                      child: TextFormField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none),
                            fillColor: Colors.grey.withOpacity(0.10),
                            filled: true,
                            suffixIcon: const Icon(Icons.filter_list),
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search ",
                            hintStyle:
                                TextStyle(fontSize: 15.sp, color: Colors.grey)),
                      ),
                    ),
                  ),
          ),

          /// **Scrollable Content**
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: const [
                  BodyTile1(), // Horizontal Scrollable
                  BodyTile2(), // Horizontal Scrollable
                  BodyTile3(), // Vertical Scrollable
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// **1st Tile - Horizontally Scrollable**
class BodyTile1 extends StatelessWidget {
  const BodyTile1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What are you looking for",
            style: TextStyle(fontSize: 19.sp),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 80.h, // ListView ke liye fixed height
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Column(
                  children: [
                    CustomIconButton(
                      width: 60,
                      assetSt: AssetsConsts.icNotification,
                    ),
                    Text("Rent"),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// **2nd Tile - Horizontally Scrollable**
class BodyTile2 extends ConsumerWidget {
  const BodyTile2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
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
            height: 200.h, // ListView ke liye fixed height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
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
            ),
          ),
        ],
      ),
    );
  }
}

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
