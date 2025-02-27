import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'dart:convert';

import '../../../../../core/utils/ui_utils/constants/app_constant.dart';
import '../../../../customs/custom_textformfield.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLocation;
  LatLng? _selectedLocation;
  String _selectedAddress = "Move the map to select a location";
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _locationPermissionGranted = false;
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  /// Get user's current location
  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    _locationPermissionGranted = true;
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _selectedLocation = _currentLocation;
      _fetchAddress(_selectedLocation!);
    });
  }

  /// Fetch address from lat/lng
  Future<void> _fetchAddress(LatLng latLng) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLng.latitude}&lon=${latLng.longitude}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _selectedAddress = data['display_name'] ?? "Address not found";
      });
    }
  }

  /// Search for locations within 100km radius
  Future<void> _searchLocation(String query) async {
    if (_currentLocation == null) return;

    final double lat = _currentLocation!.latitude;
    final double lon = _currentLocation!.longitude;
    final url =
        "https://nominatim.openstreetmap.org/search?format=json&q=$query&lat=$lat&lon=$lon&radius=50000&limit=10";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _searchResults = data
            .map((place) => {
                  "name": place["display_name"],
                  "lat": double.parse(place["lat"]),
                  "lon": double.parse(place["lon"]),
                })
            .toList();
      });
    }
  }

  /// Update selected location from search
  void _selectLocation(double lat, double lon) {
    setState(() {
      _selectedLocation = LatLng(lat, lon);
      _searchResults = [];
      searchController.clear();
    });

    // Move the map to the new location
    mapController.move(_selectedLocation!, 17);

    // Fetch the address of the new selected location
    _fetchAddress(_selectedLocation!);
  }

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.done,
                  color: CColors.primary,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              /// Map Section - Half Screen Square
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _locationPermissionGranted
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: FlutterMap(
                              mapController: mapController,
                              options: MapOptions(
                                center: _selectedLocation ??
                                    LatLng(28.7041, 77.1025),
                                zoom: 14,
                                onPositionChanged: (position, hasGesture) {
                                  if (hasGesture) {
                                    _debounce
                                        ?.cancel(); // Cancel previous timer if exists
                                    _debounce =
                                        Timer(const Duration(seconds: 1), () {
                                      setState(() {
                                        _selectedLocation = position.center;
                                      });
                                      _fetchAddress(_selectedLocation!);
                                    });
                                  }
                                },
                              ),
                              children: [
                                TileLayer(urlTemplate: MapConstants.mapTileUrl),
                              ],
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                            strokeWidth: 0.7,
                          )),

                    /// Pointer in the center of the map
                    if (_locationPermissionGranted)
                      const Icon(Icons.location_pin,
                          color: Colors.red, size: 40),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              /// Show Selected Address
              Text(
                _selectedAddress,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 16.0),

              /// Search Field
              CustomTextformField(
                cont: searchController,
                labelText: 'Search Location',
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _searchLocation(value);
                  } else {
                    setState(() {
                      _searchResults.clear();
                    });
                  }
                },
              ),

              const SizedBox(height: 12),

              /// Search Results
              _searchResults.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_searchResults[index]["name"]),
                            onTap: () {
                              _selectLocation(_searchResults[index]["lat"],
                                  _searchResults[index]["lon"]);
                            },
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ));
  }
}
