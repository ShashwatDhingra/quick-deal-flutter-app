import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/loading_manager.dart';
import 'package:quickdeal/src/data/models/property_mode.dart';
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

  AddPropertyState({
    PageController? pageController,
    this.currentPage = 0,
    List<Widget>? pages,
  }) : pages = pages ??
            [
              const FirstPage(),
              const SecondPage(),
              const ThirdPage(),
              const FourthPage(),
            ];

  // CopyWith Method
  AddPropertyState copyWith({
    PageController? pageController,
    int? currentPage,
    List<Widget>? pages,
  }) {
    return AddPropertyState(
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
    );
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
      if (fourthPageNotifier.canNextPage()) {}
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
  }

  Future<bool> addProperty(WidgetRef ref) async {
    final firstPageState = ref.read(firstPageStateProvider);
    final secondPageState = ref.read(secondPageStateProvider);
    final thirdPageState = ref.read(thirdPageStateProvider);
    final fourthPageState = ref.read(fourthPageStateProvider);
    try {
      LoadingManager.showLoading();
      final response = await state.propertyRepository.addProperty(Property(title: firstPageState.propertyTitleController.text, category: firstPageState.propertyCategory, price: double.parse(firstPageState.priceController.text), location: Location(address: '', city: '', state: '', pincode: 121001)));
      if (response?.success ?? false) {
        response?.message?.showToast();
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
