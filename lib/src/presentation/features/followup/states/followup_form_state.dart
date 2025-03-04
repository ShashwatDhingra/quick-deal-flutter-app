import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/data/repository/followup_repository.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

import '../../../../core/utils/ui_utils/loading_manager.dart';
import '../../../../data/api_exception.dart';
import '../../../global/user_provider.dart';

class FollowupFormState {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final bool isReminderOn;
  final TextEditingController reminderDateController;
  FollowupRepository followupRepository = FollowupRepository();

  FollowupFormState(
      {TextEditingController? nameController,
      TextEditingController? phoneController,
      bool? isReminderOn,
      TextEditingController? reminderDateController})
      : nameController = nameController ?? TextEditingController(),
        phoneController = phoneController ?? TextEditingController(),
        isReminderOn = isReminderOn ?? false,
        reminderDateController =
            reminderDateController ?? TextEditingController();

  FollowupFormState copyWith(
      {TextEditingController? nameController,
      TextEditingController? phoneController,
      bool? isReminderOn,
      TextEditingController? reminderDateController}) {
    return FollowupFormState(
        nameController: nameController ?? this.nameController,
        phoneController: phoneController ?? this.phoneController,
        isReminderOn: isReminderOn ?? this.isReminderOn,
        reminderDateController:
            reminderDateController ?? this.reminderDateController);
  }
}

class FollowupFormStateNotifier extends StateNotifier<FollowupFormState> {
  final leadFormKey = GlobalKey<FormState>();
  FollowupFormStateNotifier() : super(FollowupFormState());

  void clearAllControllers() {
    state.nameController.clear();
    state.phoneController.clear();
    state.copyWith(isReminderOn: false);
    state.copyWith(reminderDateController: TextEditingController());
  }

//Create Lead
  Future<bool> createFollowup(WidgetRef ref, String propertyId) async {
    try {
      if (!leadFormKey.currentState!.validate()) {
        return false;
      }

      LoadingManager.showLoading();
      final response = await state.followupRepository.createFollowup({
        "name": state.nameController.text,
        "phone": state.phoneController.text,
        "followUpBy": ref.read(userProvider)!.id,
        "property": propertyId,
        "reminder": state.isReminderOn,
        "reminderDate": state.reminderDateController.text.toString()
      });
      if (response?.success ?? false) {
        response?.message?.showToast();
        clearAllControllers();
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
final followupFormStateProvider =
    StateNotifierProvider<FollowupFormStateNotifier, FollowupFormState>(
        (ref) => FollowupFormStateNotifier());
