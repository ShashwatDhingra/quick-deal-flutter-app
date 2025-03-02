import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

class FeedbackState {
  final TextEditingController experienceController;
  final TextEditingController improvementController;
  final TextEditingController commentsController;
  double rating;

  FeedbackState({
    TextEditingController? experienceController,
    TextEditingController? improvementController,
    TextEditingController? commentsController,
    double? rating,
  })  : experienceController = experienceController ?? TextEditingController(),
        improvementController =
            improvementController ?? TextEditingController(),
        commentsController = commentsController ?? TextEditingController(),
        rating = rating ?? 0;

  FeedbackState copyWith({
    TextEditingController? experienceController,
    TextEditingController? improvementController,
    TextEditingController? commentsController,
    double? rating,
  }) {
    return FeedbackState(
      experienceController: experienceController ?? this.experienceController,
      improvementController:
          improvementController ?? this.improvementController,
      commentsController: commentsController ?? this.commentsController,
      rating: rating ?? this.rating,
    );
  }
}

class FeedbackStateNotifier extends StateNotifier<FeedbackState> {
  final feedbackFormKey = GlobalKey<FormState>();

  FeedbackStateNotifier() : super(FeedbackState());

  void updateRating(double value) {
    state = state.copyWith(rating: value);
  }

  void clearAllControllers() {
    state.experienceController.clear();
    state.improvementController.clear();
    state.commentsController.clear();
    state = state.copyWith(rating: 0);
  }

  Future<void> submitFeedback(WidgetRef ref) async {
    if (feedbackFormKey.currentState!.validate()) {
      // Process feedback data
      // print('Rating: ${state.rating}');
      // print('Experience: ${state.experienceController.text}');
      // print('Improvement: ${state.improvementController.text}');
      // print('Comments: ${state.commentsController.text}');

      // Show success message
      'Feedback submitted successfully!'.showToast();
    }
  }
}

final feedbackStateProvider =
    StateNotifierProvider<FeedbackStateNotifier, FeedbackState>(
        (ref) => FeedbackStateNotifier());
