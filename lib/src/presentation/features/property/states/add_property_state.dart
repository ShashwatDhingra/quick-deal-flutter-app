
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/loading_manager.dart';
import 'package:quickdeal/src/data/models/property_model.dart';
import 'package:quickdeal/src/data/repository/property_repository.dart';
import 'package:quickdeal/src/presentation/features/property/states/first_page_state.dart';
import 'package:quickdeal/src/presentation/features/property/states/fourth_page_state.dart';
import 'package:quickdeal/src/presentation/features/property/states/second_page_state.dart';
import 'package:quickdeal/src/presentation/features/property/states/thrid_page_state.dart';

import '../../../../data/api_exception.dart';
import '../ui/screens/pages/first_page.dart';
import '../ui/screens/pages/fourth_page.dart';
import '../ui/screens/pages/second_page.dart';
import '../ui/screens/pages/third_page.dart';

class AddPropertyState {
  final int currentPage;
  final List<Widget> pages;
  final PropertyRepository propertyRepository = PropertyRepository();
  final bool isFormCompleted;

  AddPropertyState(
      {PageController? pageController,
      this.currentPage = 0,
      List<Widget>? pages,
      bool? isFormCompleted})
      : pages = pages ??
            [
              const FirstPage(),
              const SecondPage(),
              const ThirdPage(),
              const FourthPage(),
            ],
        isFormCompleted = isFormCompleted ?? false;

  // CopyWith Method
  AddPropertyState copyWith(
      {PageController? pageController,
      int? currentPage,
      List<Widget>? pages,
      bool? isFormCompleted}) {
    return AddPropertyState(
        currentPage: currentPage ?? this.currentPage,
        pages: pages ?? this.pages,
        isFormCompleted: isFormCompleted ?? this.isFormCompleted);
  }
}

class AddPropertyStateNotifier extends StateNotifier<AddPropertyState> {
  final Ref ref;
  final PageController pageController = PageController();
  AddPropertyStateNotifier(this.ref) : super(AddPropertyState());

  bool canPreviousPage() {
    if (state.currentPage > 0) {
      return true;
    }
    return false;
  }

  bool canNextPage() {
    final firstPageNotifier = ref.read(firstPageStateProvider.notifier);
    final secondPageNotifier = ref.read(secondPageStateProvider.notifier);
    final thirdPageNotifier = ref.read(thirdPageStateProvider.notifier);
    final fourthPageNotifier = ref.read(fourthPageStateProvider.notifier);

    // Checking for FirstPage Conditions
    if ((state.currentPage == 0) && firstPageNotifier.canNextPage()) {
      return true;
    }

    // Checking for SecondPage Condition
    if ((state.currentPage == 1) && secondPageNotifier.canNextPage()) {
      return true;
    }

    // Checking for ThirdPage Condition
    if ((state.currentPage == 2) && thirdPageNotifier.canNextPage()) {
      return true;
    }

    // Checking for LastPage Condition.
    if ((state.currentPage + 1) == state.pages.length) {
      if (fourthPageNotifier.canNextPage()) {
        addProperty();
      }
      return false;
    }

    return false;
  }

  void goToPage(int index) {
    if (index >= 0 && index < state.pages.length) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      state = state.copyWith(currentPage: index);
    }
  }

  void goToPrevioudPage() {
    goToPage(state.currentPage - 1);
  }

  void goToNextPage() {
    if (canNextPage()) {
      goToPage(state.currentPage + 1);
    }
  }

  void changePage(int index) {
    state = state.copyWith(currentPage: index);
  }

  void clearState() {
    final firstPageNotifier = ref.read(firstPageStateProvider.notifier);
    final secondPageNotifier = ref.read(secondPageStateProvider.notifier);
    final thirdPageNotifier = ref.read(thirdPageStateProvider.notifier);
    final fourthPageNotifier = ref.read(fourthPageStateProvider.notifier);

    firstPageNotifier.clearAllControllers();
    secondPageNotifier.clearAllControllers();
    thirdPageNotifier.clearAllControllers();
    fourthPageNotifier.clearAllControllers();
    state = state.copyWith(currentPage: 0, isFormCompleted: false);
  }

  Future<bool> addProperty() async {
    final firstPageState = ref.read(firstPageStateProvider);
    final secondPageState = ref.read(secondPageStateProvider);
    final thirdPageState = ref.read(thirdPageStateProvider);
    final fourthPageState = ref.read(fourthPageStateProvider);
    try {
      LoadingManager.showLoading();

      // Upload the images to cloudinary
      const cloudName = 'dzbs9y14f';
      const uploadPreset = 'quick-deal';
      const url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
      List<String> imageUrls = [];

      for (final img in secondPageState.selectedImages) {
        try {
          FormData formData = FormData.fromMap({
            'file': await MultipartFile.fromFile(img.path),
            'upload_preset': uploadPreset,
          });

          final response = await Dio().post(url, data: formData);

          if (response.statusCode == 200) {
            final imageUrl = response.data['secure_url'];
            imageUrls.add(imageUrl);
          } else {
            if (kDebugMode) {
              print('Error uploading image: ${response.data}');
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('Upload Error: $e');
          }
          return false;
        }
      }

      final response = await state.propertyRepository.addProperty(PropertyModel(
          id: '',
          title: firstPageState.propertyTitleController.text,
          description: firstPageState.contentController.text,
          category: firstPageState.propertyCategory,
          propertyType: firstPageState.propertyCategory,
          status: firstPageState.statusList,
          price: double.parse(firstPageState.priceController.text),
          images: imageUrls,
          bedrooms: int.tryParse(thirdPageState.bedroomNoController.text) ?? 0,
          bathrooms:
              int.tryParse(thirdPageState.bathroomNoController.text) ?? 0,
          area: thirdPageState.areaSizeController.text,
          parking: thirdPageState.isParkingAvailable,
          constructionYear:
              int.tryParse(thirdPageState.yearBuildController.text) ?? 0,
          amenities: thirdPageState.amenetiesList,
          location: Location(
              address: fourthPageState.addressController.text,
              city: fourthPageState.cityController.text,
              state: fourthPageState.stateController.text,
              pincode: fourthPageState.pinCodeController.text,
              coordinates: Coordinates(
                  lat: double.parse(fourthPageState.latController.text),
                  lng: double.parse(fourthPageState.lngController.text)))));
      if (response?.success ?? false) {
        response?.message?.showToast();
        state = state.copyWith(isFormCompleted: true);
        // Just a delay for the UI Issue.
        await Future.delayed(1.seconds);
        clearState();
      }
      return response?.success ?? false;
    } catch (e) {
      //! Error handling
      handleError(e); // handled showing error toast itself.
      return false;
    } finally {
      LoadingManager.hideLoading();
    }
  }
}

// Provider for the same
final addPropertyStateProvider =
    StateNotifierProvider<AddPropertyStateNotifier, AddPropertyState>(
        (ref) => AddPropertyStateNotifier(ref));
