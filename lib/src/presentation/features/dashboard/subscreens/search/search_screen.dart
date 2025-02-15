import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickdeal/src/core/router/router.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../core/router/routes.dart';
import '../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../customs/custom_icon_button.dart';
import '../home/home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late DraggableScrollableController _draggableController;
  bool isScrolled = false;
  late ScrollController _scrollController;

  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openBottomSheet(context);
    });

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
    _draggableController = DraggableScrollableController();
    _draggableController.addListener(_updateSheetPosition);
  }

  void _updateSheetPosition() {
    final double currentPosition = _draggableController.size;
    setState(() {
      // Calculate opacity based on the sheet's position
      // As the sheet moves down, opacity decreases (blue to transparent)
      _opacity = currentPosition / 0.86; // 0.86 is the initial size
    });
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white, // Make the background transparent
      barrierColor: Colors.transparent, // Remove the barrier color
      builder: (context) {
        return DraggableScrollableSheet(
          controller: _draggableController,
          initialChildSize: 0.86,
          minChildSize: 0.08, // Adjusted to show the handle bar
          maxChildSize: 0.86,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.transparent, // Bottom sheet background color
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const Text("Properties"),
                  SizedBox(
                    height: 15.h,
                  ),
                  Expanded(
                    child:
                        NotificationListener<DraggableScrollableNotification>(
                      onNotification: (notification) {
                        if (notification.extent <= 0.08) {
                          // Handle button tak hi rokna h
                          _draggableController.animateTo(
                            0.08, // Fixed stop point
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                          return true;
                        }
                        return false;
                      },
                      child: ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemCount: 15,
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
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  LatLng location =
      const LatLng(51.509364, -0.128928); // Latitude and longitude
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Bottom Sheet (Positioned behind the main content)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.86,
                color:
                    Colors.transparent, // Ensure it doesn't block the content
              ),
            ),

            // FlutterMap (Map Content)
            FlutterMap(
              options: const MapOptions(
                center:
                    LatLng(51.509364, -0.128928), // Initial map center (London)
                zoom: 13.0, // Initial zoom level
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName:
                      'com.example.app', // Required for OpenStreetMap
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point:
                          const LatLng(51.509364, -0.128928), // Marker position
                      child: InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.navigation,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Main Content (Column with Search Bar)
            Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isScrolled ? 0.0 : 1.0,
                  child: Container(
                    color: Colors.white.withOpacity(
                        _opacity == 0.09302325581395349
                            ? 0
                            : _opacity), // Blue to transparent
                    height: 200.h,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide.none),
                              fillColor: _opacity == 0.09302325581395349
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.10),
                              filled: true,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.SearchScreen);
                                  },
                                  child: const Icon(Icons.filter_list)),
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search ",
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.10),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Icon(Icons.filter_alt_outlined),
                                          Text("All")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Add other widgets here if needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}
