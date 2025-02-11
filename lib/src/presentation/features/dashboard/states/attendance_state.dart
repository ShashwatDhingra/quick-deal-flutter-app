
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

class AttendanceState {
  final List<String> attendanceList;
  final bool isAttendanceListLoading;

  // In constructor we generally initialize with default value of variables.
  AttendanceState(
      {this.attendanceList = const [], this.isAttendanceListLoading = false});

  // Method to copy the state with update version
  AttendanceState copyWith({
    List<String>? attendanceList,
    bool? isAttendanceListLoading,
  }) {
    return AttendanceState(
        attendanceList: attendanceList ?? this.attendanceList,
        isAttendanceListLoading:
            isAttendanceListLoading ?? this.isAttendanceListLoading);
  }
}

class AttendanceStateNotifier extends StateNotifier<AttendanceState> {
  // Initialize the HomeState in super method of HomeStateNotifier
  AttendanceStateNotifier() : super(AttendanceState());

  Future<void> fetchAttendanceList() async {
    toogleAttendanceListLoading(true);
    try {
      await Future.delayed(2.seconds);
      state =
          state.copyWith(attendanceList: ['1', '2', '3', '4', '5', '6', '7']);
    } finally {
      toogleAttendanceListLoading(false);
    }
  }

  void toogleAttendanceListLoading(bool status) {
    state = state.copyWith(isAttendanceListLoading: status);
  }
}

// Provider for the same
final attendanceStateProvider =
    StateNotifierProvider<AttendanceStateNotifier, AttendanceState>(
        (ref) => AttendanceStateNotifier());
