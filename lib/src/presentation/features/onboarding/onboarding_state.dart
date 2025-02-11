import 'package:riverpod/riverpod.dart';

// This State class made to defines states/variable of State class.
class OnboardingState {
  final int currentIndex;
  final List<String> onBoardingMessageTitle;
  final List<String> onBoardingMessageSubtitles;

  OnboardingState(
      {this.currentIndex = 0,
      this.onBoardingMessageTitle = const [
        'Welcome to QuickDeal!',
        'Manage Stress Effectively',
        'Plan for Success',
        'Navigate Your Work Journey Efficient & Easy'
      ],
      this.onBoardingMessageSubtitles = const [
        'Make Smart Decisions! Set clear timelines for projects and celebrate your achievements!',
        'Stay Balanced! Track your workload and maintain a healthy stress level with ease.',
        'Your Journey Starts Here! Earn achievement badges as you conquer your tasks. Let’s get started!',
        'Increase your work management & career development radically'
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
