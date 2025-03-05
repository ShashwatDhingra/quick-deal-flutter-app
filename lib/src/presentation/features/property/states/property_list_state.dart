import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/data/models/property_model.dart';
import 'package:quickdeal/src/data/repository/property_repository.dart';

import '../../../../core/utils/ui_utils/loading_manager.dart';
import '../../../../data/api_exception.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';


class PropertyListState {
  List<PropertyModel> propertyList;
  PropertyRepository propertyRepo = PropertyRepository();

  PropertyListState({List<PropertyModel>? propertyList})
      : propertyList = propertyList ?? [];

    
    PropertyListState copyWith({
    List<PropertyModel>? propertyList
  }) {
    return PropertyListState(
      propertyList: propertyList ?? this.propertyList
    );
  }
}

class LeadStateNotifier extends StateNotifier<PropertyListState> {
  LeadStateNotifier() : super(PropertyListState());

  /// fetch Leads
  Future<void> fetchProperties() async {
    try {
      LoadingManager.showLoading();
      final response = await state.propertyRepo.fetchProperty();

      if (response?.success ?? false) {
        var data = response?.data;

        if (data is List<dynamic>) {
          state = state.copyWith(
              propertyList:
                  data.map((element) => PropertyModel.fromJson(element)).toList());
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
final propertyStateProvider =
    StateNotifierProvider<LeadStateNotifier, PropertyListState>(
        (ref) => LeadStateNotifier());
