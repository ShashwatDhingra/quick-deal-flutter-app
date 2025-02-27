import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/presentation/features/property/states/first_page_state.dart';
import 'package:quickdeal/src/presentation/features/property/states/second_page_state.dart';
import 'package:quickdeal/src/presentation/features/property/states/thrid_page_state.dart';

import '../ui/screens/pages/first_page.dart';
import '../ui/screens/pages/fourth_page.dart';
import '../ui/screens/pages/second_page.dart';
import '../ui/screens/pages/third_page.dart';

class AddPropertyState {
  final int currentPage;
  final List<Widget> pages;

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

    if ((state.currentPage + 1) == state.pages.length) {
      return false;
    }

    // Checking for FirstPage Conditions
    if ((state.currentPage == 0) && firstPageNotifier.canNextPage()) {
      return true;
    }

    // Checking for SecondPage Condition
    if ((state.currentPage == 1) && secondPageNotifier.canNextPage()) {
      return true;
    }

    if ((state.currentPage == 2) && thirdPageNotifier.canNextPage()) {
      return true;
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
    firstPageNotifier.clearAllControllers();
  }
}

// Provider for the same
final addPropertyStateProvider =
    StateNotifierProvider<AddPropertyStateNotifier, AddPropertyState>(
        (ref) => AddPropertyStateNotifier(ref));
