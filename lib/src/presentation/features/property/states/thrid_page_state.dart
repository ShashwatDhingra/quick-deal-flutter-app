import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThirdPageState {
  final TextEditingController bedroomNoController;
  final TextEditingController bathroomNoController;
  final TextEditingController areaSizeController;
  final TextEditingController twoWheelerParkingController;
  final TextEditingController fourWheelerParkingController;
  final TextEditingController yearBuildController;

  final List<String> featureList;
  final List<String> securityFeatureList;
  final List<String> amenetiesList;

  final bool isParkingAvailable;

  ThirdPageState({
    TextEditingController? bedroomNoController,
    TextEditingController? bathroomNoController,
    TextEditingController? areaSizeController,
    TextEditingController? twoWheelerParkingController,
    TextEditingController? fourWheelerParkingController,
    TextEditingController? yearBuildController,
    List<String>? featureList,
    List<String>? securityFeatureList,
    List<String>? amenetiesList,
    bool? isParkingAvailable,
  })  : bedroomNoController =
            bedroomNoController ?? TextEditingController(text: '0'),
        bathroomNoController =
            bathroomNoController ?? TextEditingController(text: '0'),
        areaSizeController = areaSizeController ?? TextEditingController(),
        twoWheelerParkingController =
            twoWheelerParkingController ?? TextEditingController(text: '0'),
        fourWheelerParkingController =
            fourWheelerParkingController ?? TextEditingController(text: '0'),
        yearBuildController = yearBuildController ?? TextEditingController(),
        featureList = featureList ?? [],
        securityFeatureList = securityFeatureList ?? [],
        amenetiesList = amenetiesList ?? [],
        isParkingAvailable = isParkingAvailable ?? false;

  ThirdPageState copyWith({
    TextEditingController? bedroomNoController,
    TextEditingController? bathroomNoController,
    TextEditingController? areaSizeController,
    TextEditingController? twoWheelerParkingController,
    TextEditingController? fourWheelerParkingController,
    TextEditingController? yearBuildController,
    List<String>? featureList,
    List<String>? securityFeatureList,
    List<String>? amenetiesList,
    bool? isParkingAvailable,
  }) {
    return ThirdPageState(
        bedroomNoController: bedroomNoController ?? this.bedroomNoController,
        bathroomNoController: bathroomNoController ?? this.bathroomNoController,
        areaSizeController: areaSizeController ?? this.areaSizeController,
        twoWheelerParkingController:
            twoWheelerParkingController ?? this.twoWheelerParkingController,
        fourWheelerParkingController:
            fourWheelerParkingController ?? this.fourWheelerParkingController,
        yearBuildController: yearBuildController ?? this.yearBuildController,
        featureList: featureList ?? this.featureList,
        securityFeatureList: securityFeatureList ?? this.securityFeatureList,
        amenetiesList: amenetiesList ?? this.amenetiesList,
        isParkingAvailable: isParkingAvailable ?? this.isParkingAvailable);
  }
}

class ThirdPageStateNotifier extends StateNotifier<ThirdPageState> {
  final thirdPageFormKey = GlobalKey<FormState>();
  ThirdPageStateNotifier() : super(ThirdPageState());

  bool canNextPage() {
    if (thirdPageFormKey.currentState == null) {
      return false; // Avoid null issue
    }
    if (!thirdPageFormKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  void updateFeatureList(List<String> newList) {
    state = state.copyWith(featureList: [...newList]);
  }

  void updateSecurityFeatureList(List<String> newList) {
    state = state.copyWith(securityFeatureList: [...newList]);
  }

  void updateAmenetiesList(List<String> newList) {
    state = state.copyWith(amenetiesList: [...newList]);
  }

  void updateIsParkingValue(bool val) {
    state = state.copyWith(isParkingAvailable: val);
  }

  void clearAllControllers() {
    state.bedroomNoController.clear();
    state.bathroomNoController.clear();
    state.areaSizeController.clear();
    state.twoWheelerParkingController.clear();
    state.fourWheelerParkingController.clear();
    state.yearBuildController.clear();

    state.featureList.clear();
    state.securityFeatureList.clear();
    state.amenetiesList.clear();

    state = state.copyWith(isParkingAvailable: false);
  }
}

// Provider for the same
final thirdPageStateProvider =
    StateNotifierProvider<ThirdPageStateNotifier, ThirdPageState>(
        (ref) => ThirdPageStateNotifier());
