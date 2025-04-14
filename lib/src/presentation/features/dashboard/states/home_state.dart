import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/utils/ui_utils/loading_manager.dart';
import '../../../../data/api_exception.dart';
import '../../../../data/models/property_model.dart';
import '../../../../data/repository/property_repository.dart';

class HomeState {
  List<PropertyModel> propertyList;
  PropertyRepository propertyRepo = PropertyRepository();
  bool bodyTile2Loading = false;

  // In constructor we generally initialize with default value of variables.
  HomeState({List<PropertyModel>? propertyList, bool? bodyTile2Loading})
      : propertyList = propertyList ?? [],
        bodyTile2Loading = false;

  // Method to copy the state with update version
  HomeState copyWith(
      {List<PropertyModel>? propertyList, bool? bodyTile2Loading}) {
    return HomeState(
        propertyList: propertyList ?? this.propertyList,
        bodyTile2Loading: bodyTile2Loading ?? this.bodyTile2Loading);
  }
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  // Initialize the HomeState in super method of HomeStateNotifier
  HomeStateNotifier() : super(HomeState());

  /// fetch Properties
  Future<void> fetchProperties() async {
    try {
      state = state.copyWith(bodyTile2Loading: true);
      final response = await state.propertyRepo.fetchProperty('');

      if (response?.success ?? false) {
        var data = response?.data;

        if (data is List<dynamic>) {
          state = state.copyWith(
              propertyList: data
                  .map((element) => PropertyModel.fromJson(element))
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
final homeStateProvider = StateNotifierProvider<HomeStateNotifier, HomeState>(
    (ref) => HomeStateNotifier());
