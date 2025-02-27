import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstPageState {
  final TextEditingController propertyTitleController;
  final TextEditingController contentController;
  final TextEditingController priceController;
  final TextEditingController rentIncController;

  final List<String> propertyTypeList;
  final List<String> statusList;

  FirstPageState({
    TextEditingController? propertyTitleController,
    TextEditingController? contentController,
    TextEditingController? priceController,
    TextEditingController? rentIncController,
    List<String>? propertyTypeList,
    List<String>? statusList,
  })  : propertyTitleController =
            propertyTitleController ?? TextEditingController(),
        contentController = contentController ?? TextEditingController(),
        priceController = priceController ?? TextEditingController(),
        rentIncController = rentIncController ?? TextEditingController(),
        propertyTypeList = propertyTypeList ?? [],
        statusList = statusList ?? [];

  FirstPageState copyWith({
    TextEditingController? propertyTitleController,
    TextEditingController? contentController,
    TextEditingController? priceController,
    TextEditingController? rentIncController,
    List<String>? propertyTypeList,
    List<String>? statusList,
  }) {
    return FirstPageState(
      propertyTitleController:
          propertyTitleController ?? this.propertyTitleController,
      contentController: contentController ?? this.contentController,
      priceController: priceController ?? this.priceController,
      rentIncController: rentIncController ?? this.rentIncController,
      propertyTypeList: propertyTypeList ?? this.propertyTypeList,
      statusList: statusList ?? this.statusList,
    );
  }
}

class FirstPageStateNotifier extends StateNotifier<FirstPageState> {
  final firstPageFormKey = GlobalKey<FormState>();
  FirstPageStateNotifier() : super(FirstPageState());

  bool canNextPage() {
    if (firstPageFormKey.currentState == null) {
      return false; // Avoid null issue
    }
    if (!firstPageFormKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  void updatePropertyTypeList(List<String> newList) {
    state = state.copyWith(propertyTypeList: [...newList]);
  }

  void updateStatusTypeList(List<String> newList) {
    state = state.copyWith(statusList: [...newList]);
  }

  void clearAllControllers() {
    state.contentController.clear();
    state.priceController.clear();
    state.propertyTitleController.clear();
    state.rentIncController.clear();
    state.statusList.clear();
    state.propertyTypeList.clear();
  }
}

// Provider for the same
final firstPageStateProvider =
    StateNotifierProvider<FirstPageStateNotifier, FirstPageState>(
        (ref) => FirstPageStateNotifier());
