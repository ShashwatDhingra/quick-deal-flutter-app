import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/ui_utils/loading_manager.dart';
import '../../../../data/api_exception.dart';
import '../../../../data/models/lead_model.dart';
import '../../../../data/repository/lead_repository.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../global/user_provider.dart';

class LeadState {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emalController;
  final TextEditingController remarksController;
  String propertyCategory;
  String status;
  int page;
  int limit;
  List<LeadModel> leadList;

  LeadState({
    TextEditingController? nameController,
    TextEditingController? phoneController,
    TextEditingController? emalController,
    TextEditingController? remarksController,
    String? propertyCategory,
    String? status,
    int? page,
    int? limit,
    List<LeadModel>? leadList,
  })  : nameController = nameController ?? TextEditingController(),
        phoneController = phoneController ?? TextEditingController(),
        emalController = emalController ?? TextEditingController(),
        remarksController = remarksController ?? TextEditingController(),
        propertyCategory = propertyCategory ?? "",
        status = status ?? "",
        page = page ?? 1,
        limit = limit ?? 10,
        leadList = leadList ?? [];

  LeadState copyWith({
    TextEditingController? nameController,
    TextEditingController? phoneController,
    TextEditingController? emalController,
    TextEditingController? remarksController,
    String? propertyCategory,
    String? status,
    int? page,
    int? limit,
    List<LeadModel>? leadList,
  }) {
    return LeadState(
      nameController: nameController ?? this.nameController,
      phoneController: phoneController ?? this.phoneController,
      emalController: emalController ?? this.emalController,
      remarksController: remarksController ?? this.remarksController,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      status: status ?? this.status,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      leadList: leadList ?? this.leadList,
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
    state = state.copyWith(
      propertyCategory: "",
      status: "",
    );
  }

//Create Lead
  Future<bool> createLead(WidgetRef ref) async {
    LeadRepository leadRepo = LeadRepository();

    LeadModel leadModel;
    try {
      if (!leadFormKey.currentState!.validate()) {
        return false;
      }
      final user = ref.read(userProvider);

      LoadingManager.showLoading();
      final response = await leadRepo.addLead({
        "name": state.nameController.text,
        "phone": state.phoneController.text,
        "email": state.emalController.text,
        "assigned": user!.id ?? "",
        "propertytype": state.propertyCategory,
        "status": state.status,
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
  Future<void> fetchLeads() async {
    LeadRepository leadRepo = LeadRepository();

    try {
      LoadingManager.showLoading();
      final response =
          await leadRepo.fetchLead("?page=${state.page}&limit=${state.limit}");

      if (response?.success ?? false) {
        var data = response?.data;

        if (data is List<dynamic>) {
          state = state.copyWith(
              leadList:
                  data.map((element) => LeadModel.fromJson(element)).toList());
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
final leadStateProvider = StateNotifierProvider<LeadStateNotifier, LeadState>(
    (ref) => LeadStateNotifier());
