import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/home/home_screen.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/utils/ui_utils/constants/app_constant.dart';
import '../../../../../core/utils/ui_utils/constants/colors.dart';
import 'widgets/custom_searchbar.dart';
import 'widgets/filter_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late DraggableScrollableController _draggableController;
  late ScrollController _scrollController;
  late MapController _mapController;
  late PageController _pageController;

  bool _isScrolled = false;
  double _opacity = 1.0;
  int _selectedIndex = 0;

  final List<Map<String, double>> _dummyLatLngList = [
    {"lat": 28.7041, "lng": 77.1025},
    {"lat": 28.4595, "lng": 77.0266},
    {"lat": 28.5355, "lng": 77.3910},
    {"lat": 28.6139, "lng": 77.2090},
    {"lat": 28.4744, "lng": 77.5040},
    {"lat": 28.4089, "lng": 77.3178},
    {"lat": 28.5672, "lng": 77.2100},
    {"lat": 28.6664, "lng": 77.4520},
    {"lat": 28.4593, "lng": 77.1121},
    {"lat": 28.5245, "lng": 77.1855},
  ];

  @override
  void initState() {
    super.initState();
    _draggableController = DraggableScrollableController();
    _scrollController = ScrollController();
    _mapController = MapController();
    _pageController = PageController();

    _scrollController.addListener(_onScroll);
    _draggableController.addListener(_updateSheetPosition);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _openBottomSheet(context));
  }

  void _onScroll() {
    setState(() {
      _isScrolled = _scrollController.offset > 50;
    });
  }

  void _updateSheetPosition() {
    setState(() {
      _opacity = _draggableController.size / MapConstants.initialChildSize;
    });
  }

  void _openBottomSheet(BuildContext context) {
    var isDark = context.isDarkMode;
    showModalBottomSheet(
      context: context,
      shape: const ContinuousRectangleBorder(),
      isScrollControlled: true,
      backgroundColor: isDark ? CColors.black : Colors.white,
      barrierColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          controller: _draggableController,
          initialChildSize: MapConstants.initialChildSize,
          minChildSize: MapConstants.minChildSize,
          maxChildSize: MapConstants.maxChildSize,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  const Text("Properties"),
                  SizedBox(height: 15.h),
                  15.h.hBox,
                  Expanded(
                    child:
                        NotificationListener<DraggableScrollableNotification>(
                      onNotification: (notification) {
                        if (notification.extent <= MapConstants.minChildSize) {
                          _draggableController.animateTo(
                              MapConstants.minChildSize,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
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
                          return SinglePropertyCard(
                            onTap: () {},
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

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    final controller = AnimationController(
        duration: MapConstants.animationDuration, vsync: this);
    final animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // CustomSearchBar(
                      //   onChanged: (value) {},
                      //   onBackPressed: () {},
                      // ),
                      // 10.vBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            4,
                            (index) => buildFilterButton(
                                icon: Icons.filter_alt_outlined,
                                text: index == 0 ? null : "All")),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 17,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("29 Results",
                                style: TextStyle(fontSize: 20.h)),
                            Text("Showing Newest Results",
                                style: TextStyle(fontSize: 10.h)),
                            // 10.vBox,
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 12.h),
                              itemCount: 15,
                              itemBuilder: (_, index) => SinglePropertyCard(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.propertyDetailScreen);
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
