import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/customs/custom_textformfield.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/app_constant.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/presentation/features/property/states/fourth_page_state.dart';
import 'package:quickdeal/src/presentation/features/property/ui/screens/map_screen.dart';

class FourthPage extends ConsumerStatefulWidget {
  const FourthPage({super.key});

  @override
  ConsumerState<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends ConsumerState<FourthPage> {
  @override
  void initState() {
    super.initState();
    final fourthPageNotifier = ref.read(fourthPageStateProvider.notifier);
    fourthPageNotifier.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fourthPageState = ref.watch(fourthPageStateProvider);
    final fourthPageNotifier = ref.read(fourthPageStateProvider.notifier);

    return Form(
      key: fourthPageNotifier.fourthPageFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              12.hBox,
              const Align(
                  alignment: Alignment.centerLeft, child: Text('Map Details')),
              16.hBox,
              fourthPageState.locationPermissionGranted &&
                      fourthPageState.currentPosition != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CircleAvatar(
                        radius: 100,
                        child: Stack(
                          children: [
                            Hero(
                              tag: 'map',
                              child: FlutterMap(
                                options: MapOptions(
                                  backgroundColor:
                                      isDark ? CColors.black : Colors.white,
                                  initialCenter: LatLng(
                                    fourthPageState.currentPosition!.latitude,
                                    fourthPageState.currentPosition!.longitude,
                                  ),
                                  initialZoom: MapConstants.initialZoom,
                                ),
                                children: [
                                  TileLayer(
                                      urlTemplate: MapConstants.mapTileUrl),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        width: 80.0,
                                        height: 80.0,
                                        point: LatLng(
                                          fourthPageState
                                              .currentPosition!.latitude,
                                          fourthPageState
                                              .currentPosition!.longitude,
                                        ),
                                        child: const Icon(Icons.location_pin,
                                            color: Colors.red, size: 40),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push(const MapScreen());
                              },
                              child: Container(
                                color: Colors.transparent,
                                width: 1200,
                                height: 1000,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: fourthPageNotifier.getCurrentLocation,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(Icons.map,
                            size: 50, color: Colors.black54),
                      ),
                    ),
              12.hBox,
              GestureDetector(
                onTap: fourthPageNotifier.getCurrentLocation,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.grey),
                    Text('Select Current Location'),
                  ],
                ),
              ),
              16.hBox,
              Row(
                children: [
                  Expanded(
                    child: CustomTextformField(
                      cont: fourthPageState.latController,
                      labelText: 'Latitude',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextformField(
                      cont: fourthPageState.lngController,
                      labelText: 'Longitude',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              12.hBox,
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Location Details')),
              12.hBox,
              CustomTextformField(
                  cont: fourthPageState.addressController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please select at least one Option';
                    }
                    return null;
                  },
                  labelText: 'Address'),
              16.hBox,
              CustomTextformField(
                cont: fourthPageState.stateController,
                labelText: 'State',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please select at least one Option';
                  }
                  return null;
                },
              ),
              16.hBox,
              CustomTextformField(
                cont: fourthPageState.cityController,
                labelText: 'City',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please select at least one Option';
                  }
                  return null;
                },
              ),
              16.hBox,
              CustomTextformField(
                cont: fourthPageState.pinCodeController,
                labelText: 'Pin Code',
                keyboardType: TextInputType.number,
                maxText: 6,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please select at least one Option';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
