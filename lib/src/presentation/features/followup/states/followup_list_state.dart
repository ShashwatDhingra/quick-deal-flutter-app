import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/ui_utils/loading_manager.dart';
import '../../../../data/api_exception.dart';
import '../../../../data/models/followup_model.dart';
import '../../../../data/repository/followup_repository.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';


class FollowupListState {
  int page;
  int limit;
  bool isLoading;
  List<FollowupModel> followupList;

  FollowupListState({
    int? page,
    int? limit,
    bool? isLoading,
    List<FollowupModel>? followupList,
  })  : page = page ?? 1,
        limit = limit ?? 10,
        isLoading = isLoading ?? false,
        followupList = followupList ?? [];

  FollowupListState copyWith({
    int? page,
    int? limit,
    bool? isLoading,
    List<FollowupModel>? followupList,
  }) {
    return FollowupListState(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      isLoading: isLoading ?? isLoading,
      followupList: followupList ?? this.followupList,
    );
  }
}

class FollowupStateNotifier extends StateNotifier<FollowupListState> {
  final leadFormKey = GlobalKey<FormState>();
  FollowupStateNotifier() : super(FollowupListState());

  /// Fetch Follow-Ups.
  Future<void> fetchFollowup(String? propertyId) async {
    FollowupRepository followupRepo = FollowupRepository();

    try {
      LoadingManager.showLoading();
      state = state.copyWith(isLoading: true);

      String filter = "";
      if (propertyId == null) {
        filter = "?page=${state.page}&limit=${state.limit}";
      } else {
        filter =
            "?page=${state.page}&limit=${state.limit}&filters[property]=$propertyId";
      }
      final response = await followupRepo.fetchFollowup(filter);

      if (response?.success ?? false) {
        var data = response?.data;

        if (data is List<dynamic>) {
          state = state.copyWith(
              followupList: data
                  .map((element) => FollowupModel.fromJson(element))
                  .toList(),
              isLoading: false);
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
final followupListStateProvider =
    StateNotifierProvider<FollowupStateNotifier, FollowupListState>(
        (ref) => FollowupStateNotifier());
