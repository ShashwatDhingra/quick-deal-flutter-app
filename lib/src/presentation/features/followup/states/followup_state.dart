import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/ui_utils/loading_manager.dart';
import '../../../../data/api_exception.dart';
import '../../../../data/models/followup_model.dart';
import '../../../../data/repository/followup_repository.dart';
import '../../../../data/repository/lead_repository.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../global/user_provider.dart';

class FollowupState {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emalController;
  final TextEditingController remarksController;
  String propertyCategory;
  String status;
  int page;
  int limit;
  List<FollowupModel> leadList;

  FollowupState({
    TextEditingController? nameController,
    TextEditingController? phoneController,
    TextEditingController? emalController,
    TextEditingController? remarksController,
    String? propertyCategory,
    String? status,
    int? page,
    int? limit,
    List<FollowupModel>? leadList,
  })  : nameController = nameController ?? TextEditingController(),
        phoneController = phoneController ?? TextEditingController(),
        emalController = emalController ?? TextEditingController(),
        remarksController = remarksController ?? TextEditingController(),
        propertyCategory = propertyCategory ?? "",
        status = status ?? "",
        page = page ?? 1,
        limit = limit ?? 10,
        leadList = leadList ?? [];

  FollowupState copyWith({
    TextEditingController? nameController,
    TextEditingController? phoneController,
    TextEditingController? emalController,
    TextEditingController? remarksController,
    int? page,
    int? limit,
    List<FollowupModel>? leadList,
  }) {
    return FollowupState(
      nameController: nameController ?? this.nameController,
      phoneController: phoneController ?? this.phoneController,
      emalController: emalController ?? this.emalController,
      remarksController: remarksController ?? this.remarksController,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      leadList: leadList ?? this.leadList,
    );
  }
}

class FollowupStateNotifier extends StateNotifier<FollowupState> {
  final leadFormKey = GlobalKey<FormState>();
  FollowupStateNotifier() : super(FollowupState());

  void clearAllControllers() {
    state.nameController.clear();
    state.phoneController.clear();
    state.emalController.clear();
    state.remarksController.clear();
  }

//Create Lead
  Future<bool> createFollowup(WidgetRef ref, String propertyId) async {
    LeadRepository leadRepo = LeadRepository();

    try {
      if (!leadFormKey.currentState!.validate()) {
        return false;
      }
      final user = ref.read(userProvider);

      LoadingManager.showLoading();
      final response = await leadRepo.addLead({

        
    "followUpBy": ref.read(userProvider)!.id,
    "property": propertyId,
    "comments":"Testing comments",
    "priority":"High",
    "followUpType":"Mobile App",
    "reminder": false,
    "reminderDate":"2024-02-22",

        "name": state.nameController.text,
        "phone": state.phoneController.text,
        "email": state.emalController.text,
        "assigned": user!.id ?? "",
        "remarks": state.remarksController.text,
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

// fetch Leads
  Future<void> fetchFollowup() async {
    FollowupRepository followupRepo = FollowupRepository();

    try {
      LoadingManager.showLoading();
      final response = await followupRepo
          .fetchFollowup("?page=${state.page}&limit=${state.limit}");

      if (response?.success ?? false) {
        var data = response?.data;

        if (data is List<dynamic>) {
          state = state.copyWith(
              leadList: data
                  .map((element) => FollowupModel.fromJson(element))
                  .toList());
        }
        response?.message?.showToast();
      }
    } catch (e) {
      handleError(e);
    } finally {
      LoadingManager.hideLoading();
    }
  }
}

// Provider for the same
final followupStateProvider =
    StateNotifierProvider<FollowupStateNotifier, FollowupState>(
        (ref) => FollowupStateNotifier());
