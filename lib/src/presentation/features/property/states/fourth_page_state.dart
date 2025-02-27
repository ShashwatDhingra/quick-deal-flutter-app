import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FourthPageState {
  final TextEditingController latController;
  final TextEditingController lngController;
  final TextEditingController addressController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  final TextEditingController pinCodeController;

  FourthPageState({
    TextEditingController? bedroomNoController,
    TextEditingController? bathroomNoController,
    TextEditingController? areaSizeController,
    TextEditingController? twoWheelerParkingController,
    TextEditingController? fourWheelerParkingController,
    TextEditingController? yearBuildController,
  })  : latController =
            bedroomNoController ?? TextEditingController(text: '0'),
        lngController =
            bathroomNoController ?? TextEditingController(text: '0'),
        addressController = areaSizeController ?? TextEditingController(),
        stateController =
            twoWheelerParkingController ?? TextEditingController(text: '0'),
        cityController =
            fourWheelerParkingController ?? TextEditingController(text: '0'),
        pinCodeController = yearBuildController ?? TextEditingController();

  FourthPageState copyWith({
    TextEditingController? bedroomNoController,
    TextEditingController? bathroomNoController,
    TextEditingController? areaSizeController,
    TextEditingController? twoWheelerParkingController,
    TextEditingController? fourWheelerParkingController,
    TextEditingController? yearBuildController,
  }) {
    return FourthPageState(
        bedroomNoController: bedroomNoController ?? this.latController,
        bathroomNoController: bathroomNoController ?? this.lngController,
        areaSizeController: areaSizeController ?? this.addressController,
        twoWheelerParkingController:
            twoWheelerParkingController ?? this.stateController,
        fourWheelerParkingController:
            fourWheelerParkingController ?? this.cityController,
        yearBuildController: yearBuildController ?? this.pinCodeController);
  }
}

class FourthPageStateNotifier extends StateNotifier<FourthPageState> {
  final fourthPageFormKey = GlobalKey<FormState>();
  FourthPageStateNotifier() : super(FourthPageState());

  bool canNextPage() {
    if (fourthPageFormKey.currentState == null) {
      return false; // Avoid null issue
    }
    if (!fourthPageFormKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  void clearAllControllers() {
    state.latController.clear();
    state.lngController.clear();
    state.addressController.clear();
    state.stateController.clear();
    state.cityController.clear();
    state.pinCodeController.clear();
  }
}

// Provider for the same
final fourthPageStateProvider =
    StateNotifierProvider<FourthPageStateNotifier, FourthPageState>(
        (ref) => FourthPageStateNotifier());
