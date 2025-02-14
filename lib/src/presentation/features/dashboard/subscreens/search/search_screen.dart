import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../core/router/routes.dart';
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
  double _sheetPosition = 0.86; // Initial position of the bottom sheet
  double _opacity = 1.0; // Initial opacity of the blue container

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
      _sheetPosition = currentPosition;
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
              decoration: BoxDecoration(
                color: Colors.transparent, // Bottom sheet background color
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
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

  @override
  Widget build(BuildContext context) {
    //print("opps" + _opacity.toString());
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

            // Main Content (Column with Search Bar)
            Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity:
                      isScrolled ? 0.0 : 1.0, // Keep this for scroll behavior
                  child: Container(
                    color: Colors.white.withOpacity(
                        _opacity == 0.09302325581395349
                            ? 0
                            : _opacity), // Blue to transparent
                    height: 100.h,
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
                              fillColor: Colors.grey.withOpacity(0.10),
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
                          Row(
                            children: [],
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
