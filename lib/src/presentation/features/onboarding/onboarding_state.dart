import 'package:riverpod/riverpod.dart';

import '../../../core/utils/ui_utils/constants/text_strings.dart';

// This State class made to defines states/variable of State class.
class OnboardingState {
  final int currentIndex;
  final List<String> onBoardingMessageTitle;
  final List<String> onBoardingMessageSubtitles;

  OnboardingState(
      {this.currentIndex = 0,
      this.onBoardingMessageTitle = const [
        Texts.onBoardingTitle1,
        Texts.onBoardingTitle2,
        Texts.onBoardingTitle3,
        Texts.onBoardingTitle4
      ],
      this.onBoardingMessageSubtitles = const [
        Texts.onBoardingSubTitle1,
        Texts.onBoardingSubTitle2,
        Texts.onBoardingSubTitle3,
        Texts.onBoardingSubTitle4
      ]});

  // Method to copy the state with update version
  OnboardingState copyWith({int? currentIndex}) {
    return OnboardingState(
        currentIndex: currentIndex ?? this.currentIndex,
        onBoardingMessageTitle: onBoardingMessageTitle,
        onBoardingMessageSubtitles: onBoardingMessageSubtitles);
  }
}

// We only use Notifier class to update the UI. Basically to call the method on State Class.
class OnboardingStateNotifier extends StateNotifier<OnboardingState> {
  OnboardingStateNotifier() : super(OnboardingState());

  void updatePageIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void skipToLastPage() {
    state =
        state.copyWith(currentIndex: state.onBoardingMessageTitle.length - 1);
  }

  void jumpToFirstPage() {
    state = state.copyWith(currentIndex: 0);
  }

  void nextPage() {
    if (state.currentIndex < state.onBoardingMessageTitle.length - 1) {
      updatePageIndex(state.currentIndex + 1);
    }
  }

  void preiousPage() {
    if (state.currentIndex >= 1) {
      updatePageIndex(state.currentIndex - 1);
    }
  }
}

// Provider for the same
final onboardingStateProvider =
    StateNotifierProvider<OnboardingStateNotifier, OnboardingState>(
        (ref) => OnboardingStateNotifier());
