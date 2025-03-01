import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/ui_utils/loading_manager.dart';
import '../../../../data/api_exception.dart';
import '../../../../data/repository/lead_repository.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
class LeadState {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emalController;
  final TextEditingController remarksController;

  LeadState({
    TextEditingController? nameController,
    TextEditingController? phoneController,
    TextEditingController? emalController,
    TextEditingController? remarksController,
  })  : nameController = nameController ?? TextEditingController(),
        phoneController =
            phoneController ?? phoneController ?? TextEditingController(),
        emalController = emalController ?? TextEditingController(),
        remarksController = remarksController ?? TextEditingController();

  LeadState copyWith({
    TextEditingController? nameController,
    TextEditingController? phoneController,
    TextEditingController? emalController,
    TextEditingController? remarksController,
  }) {
    return LeadState(
      nameController: nameController ?? this.nameController,
      phoneController: phoneController ?? this.phoneController,
      emalController: emalController ?? this.emalController,
      remarksController: remarksController ?? this.remarksController,
    );
  }
}

class LeadStateNotifier extends StateNotifier<LeadState> {
  final leadFormKey = GlobalKey<FormState>();
  LeadStateNotifier() : super(LeadState());

  void clearAllControllers() {
    state.nameController.clear();
    state.phoneController.clear();
    state.emalController.clear();
    state.remarksController.clear();
  }

  Future<bool> createLead(WidgetRef ref) async {
    LeadRepository leadRepo = LeadRepository();
    try {
      if (!leadFormKey.currentState!.validate()) {
        return false;
      }

      LoadingManager.showLoading();
      final response = await leadRepo.addLead({
    "name":"Testing Lead",
    "phone":7215370790,
    "email":"ajjucsss46@gmail.com", 
    "assignedTo":"username",
    "source":"mobile",
    "status":"draft",
    "remarks":"Testing remarks",
    "followUpDate":"2024-02-22"
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
final leadStateProvider = StateNotifierProvider<LeadStateNotifier, LeadState>(
    (ref) => LeadStateNotifier());
