import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class FourthPageState {
  final Position? currentPosition;
  final bool locationPermissionGranted;
  final TextEditingController latController;
  final TextEditingController lngController;
  final TextEditingController addressController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  final TextEditingController pinCodeController;

  FourthPageState({
    this.currentPosition,
    this.locationPermissionGranted = false,
    TextEditingController? latController,
    TextEditingController? lngController,
    TextEditingController? addressController,
    TextEditingController? stateController,
    TextEditingController? cityController,
    TextEditingController? pinCodeController,
  })  : latController = latController ?? TextEditingController(),
        lngController = lngController ?? TextEditingController(),
        addressController = addressController ?? TextEditingController(),
        stateController = stateController ?? TextEditingController(),
        cityController = cityController ?? TextEditingController(),
        pinCodeController = pinCodeController ?? TextEditingController();

  FourthPageState copyWith({
    Position? currentPosition,
    bool? locationPermissionGranted,
    TextEditingController? latController,
    TextEditingController? lngController,
    TextEditingController? addressController,
    TextEditingController? stateController,
    TextEditingController? cityController,
    TextEditingController? pinCodeController,
  }) {
    return FourthPageState(
      currentPosition: currentPosition ?? this.currentPosition,
      locationPermissionGranted:
          locationPermissionGranted ?? this.locationPermissionGranted,
      latController: latController ?? this.latController,
      lngController: lngController ?? this.lngController,
      addressController: addressController ?? this.addressController,
      stateController: stateController ?? this.stateController,
      cityController: cityController ?? this.cityController,
      pinCodeController: pinCodeController ?? this.pinCodeController,
    );
  }
}

class FourthPageStateNotifier extends StateNotifier<FourthPageState> {
  final fourthPageFormKey = GlobalKey<FormState>();

  FourthPageStateNotifier() : super(FourthPageState());

  bool canNextPage() {
    return fourthPageFormKey.currentState?.validate() ?? false;
  }

  void clearAllControllers() {
    state.latController.clear();
    state.lngController.clear();
    state.addressController.clear();
    state.stateController.clear();
    state.cityController.clear();
    state.pinCodeController.clear();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = state.copyWith(locationPermissionGranted: false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      state = state.copyWith(locationPermissionGranted: false);
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      state = state.copyWith(
        currentPosition: position,
        locationPermissionGranted: true,
      );
      state.latController.text = position.latitude.toString();
      state.lngController.text = position.longitude.toString();
    }
  }
}

// Provider for the same
final fourthPageStateProvider =
    StateNotifierProvider<FourthPageStateNotifier, FourthPageState>(
        (ref) => FourthPageStateNotifier());
