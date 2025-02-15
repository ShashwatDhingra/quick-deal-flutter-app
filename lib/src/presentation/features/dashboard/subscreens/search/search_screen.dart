import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickdeal/src/core/router/router.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../core/router/routes.dart';
import '../../../../customs/custom_icon_button.dart';
import '../home/home_screen.dart';

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

  final LatLng _currentLocation = const LatLng(51.509364, -0.128928);
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
      _opacity = _draggableController.size / 0.86;
    });
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      barrierColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          controller: _draggableController,
          initialChildSize: 0.86,
          minChildSize: 0.08,
          maxChildSize: 0.86,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  const Text("Properties"),
                  SizedBox(height: 15.h),
                  Expanded(
                    child:
                        NotificationListener<DraggableScrollableNotification>(
                      onNotification: (notification) {
                        if (notification.extent <= 0.08) {
                          _draggableController.animateTo(0.08,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                          return true;
                        }
                        return false;
                      },
                      child: ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
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

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(_dummyLatLngList[_selectedIndex]['lat']!,
                    _dummyLatLngList[_selectedIndex]['lng']!),
                zoom: 14.5,
                enableScrollWheel: true,
                pinchMoveThreshold: 5.7,
              ),
              children: [
                TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                MarkerLayer(
                  markers: [
                    Marker(
                      height: 40,
                      width: 40,
                      point: const LatLng(28.7041, 77.102),
                      child: const Icon(Icons.navigation,
                          color: Colors.red, size: 40),
                    ),
                    ..._dummyLatLngList.map((latLng) => Marker(
                          height: 40,
                          width: 40,
                          point: LatLng(latLng['lat']!, latLng['lng']!),
                          child: GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                _dummyLatLngList.indexOf(latLng),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              setState(() {
                                _selectedIndex =
                                    _dummyLatLngList.indexOf(latLng);
                                _animatedMapMove(
                                    LatLng(latLng['lat']!, latLng['lng']!),
                                    11.5);
                              });
                            },
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 500),
                              scale: _selectedIndex ==
                                      _dummyLatLngList.indexOf(latLng)
                                  ? 1
                                  : 0.7,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: _selectedIndex ==
                                        _dummyLatLngList.indexOf(latLng)
                                    ? 1
                                    : 0.5,
                                child: Icon(
                                  Icons.location_on,
                                  color: latLng['lat'] == null
                                      ? Colors.red
                                      : Colors.green,
                                  size: 45,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isScrolled ? 0.0 : 1.0,
                  child: Container(
                    color: Colors.white.withOpacity(
                        _opacity == 0.09302325581395349 ? 0 : _opacity),
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
                                  onTap: () => Navigator.pushNamed(
                                      context, Routes.SearchScreen),
                                  child: const Icon(Icons.filter_list)),
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          _opacity == 0.09302325581395349
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildFilterButton(
                                        icon: Icons.filter_alt_outlined),
                                    _buildFilterButton(text: "All"),
                                    _buildFilterButton(text: "All"),
                                    _buildFilterButton(text: "Custom"),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 120.h,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 150.h,
                width: MediaQuery.of(context).size.width * 0.8,
                child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: _dummyLatLngList.length,
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _selectedIndex = value;
                      _animatedMapMove(
                          LatLng(_dummyLatLngList[value]['lat']!,
                              _dummyLatLngList[value]['lng']!),
                          11.5);
                    });
                  },
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SinglePropertyCard(
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
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isScrolled ? 0.0 : 1.0,
                  child: Container(
                    color: Colors.white.withOpacity(
                        _opacity == 0.09302325581395349 ? 0 : _opacity),
                    height: 110.h,
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
                                  onTap: () => Navigator.pushNamed(
                                      context, Routes.SearchScreen),
                                  child: const Icon(Icons.filter_list)),
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          _opacity == 0.09302325581395349
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildFilterButton(
                                        icon: Icons.filter_alt_outlined),
                                    _buildFilterButton(text: "All"),
                                    _buildFilterButton(text: "All"),
                                    _buildFilterButton(text: "Custom"),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton({IconData? icon, String? text}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.10),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              children: [
                if (icon != null) Icon(icon),
                if (text != null) Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
