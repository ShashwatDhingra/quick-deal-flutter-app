import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

class SecondPageState {
  final List<XFile> selectedImages;

  SecondPageState({
    List<XFile>? selectedImages,
  }) : selectedImages = selectedImages ?? [];

  SecondPageState copyWith({List<XFile>? selectedImages}) {
    return SecondPageState(
      selectedImages: selectedImages ?? this.selectedImages,
    );
  }
}

class SecondPageStateNotifier extends StateNotifier<SecondPageState> {
  SecondPageStateNotifier() : super(SecondPageState());
  final ImagePicker _picker = ImagePicker();
  static const int maxImages = 25;

  bool canNextPage() {
    if (state.selectedImages.isEmpty) {
      'Select atleast one Image.'.showErrorToast();
      return false;
    }
    return true;
  }

  Future<void> pickImages() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      final int availableSlots = maxImages - state.selectedImages.length;
      final newImages = [
        ...state.selectedImages,
        ...pickedImages.take(availableSlots)
      ];

      state = state.copyWith(selectedImages: newImages);
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < state.selectedImages.length) {
      final updatedImages = List<XFile>.from(state.selectedImages)
        ..removeAt(index);
      state = state.copyWith(selectedImages: updatedImages);
    }
  }

  void updatePropertyTypeList(List<XFile> newList) {
    state = state.copyWith(selectedImages: [...newList]);
  }

  void clearAllControllers() {
    state.selectedImages.clear();
  }
}

// Provider for the same
final secondPageStateProvider =
    StateNotifierProvider<SecondPageStateNotifier, SecondPageState>(
        (ref) => SecondPageStateNotifier());
