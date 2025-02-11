
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:riverpod/riverpod.dart';

class HomeState {
  final List<Map<String, dynamic>> appointmentList;
  final List<String> taskList;
  final bool isAppointmentListLoading;
  final bool isTaskListLoading;

  // In constructor we generally initialize with default value of variables.
  HomeState(
      {this.appointmentList = const [],
      this.taskList = const [],
      this.isAppointmentListLoading = false,
      this.isTaskListLoading = false});

  // Method to copy the state with update version
  HomeState copyWith({
    List<Map<String, dynamic>>? appointmentList,
    List<String>? taskList,
    bool? isAppointmentListLoading,
    bool? isTaskListLoading,
  }) {
    return HomeState(
        appointmentList: appointmentList ?? this.appointmentList,
        taskList: taskList ?? this.taskList,
        isAppointmentListLoading:
            isAppointmentListLoading ?? this.isAppointmentListLoading,
        isTaskListLoading: isTaskListLoading ?? this.isTaskListLoading);
  }
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  // Initialize the HomeState in super method of HomeStateNotifier
  HomeStateNotifier() : super(HomeState());

  Future<void> fetchAppointmentList() async {
    toogleAppointmentLoading(true);
    try {
      await Future.delayed(2.seconds);
      state = state.copyWith(appointmentList: [
        {"name": "Delhi Meet", "in_time": "11:00 AM", "out_time": "1:00 PM"},
        {"name": "Delhi Meet", "in_time": "11:00 AM", "out_time": "1:00 PM"},
        {"name": "Delhi Meet", "in_time": "11:00 AM", "out_time": "1:00 PM"},
        {"name": "Delhi Meet", "in_time": "11:00 AM", "out_time": "1:00 PM"},
        {"name": "Delhi Meet", "in_time": "11:00 AM", "out_time": "1:00 PM"}
      ]);
    } finally {
      toogleAppointmentLoading(false);
    }
  }

  Future<void> fetchTaskList() async {
    toogleTaskLoading(true);
    try {
      await Future.delayed(2.seconds);
      state = state.copyWith(taskList: state.taskList);
    } finally {
      toogleTaskLoading(false);
    }
  }

  void toogleAppointmentLoading(bool status) {
    state = state.copyWith(isAppointmentListLoading: status);
  }

  void toogleTaskLoading(bool status) {
    state = state.copyWith(isTaskListLoading: status);
  }
}

// Provider for the same
final homeStateProvider = StateNotifierProvider<HomeStateNotifier, HomeState>(
    (ref) => HomeStateNotifier());
