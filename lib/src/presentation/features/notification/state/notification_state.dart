import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

class NotificationState {
  final List<Map<String, dynamic>> notifications;
  final bool isLoading;

  NotificationState({
    this.notifications = const [],
    this.isLoading = false,
  });

  NotificationState copyWith({
    List<Map<String, dynamic>>? notifications,
    bool? isLoading,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class NotificationStateNotifier extends StateNotifier<NotificationState> {
  NotificationStateNotifier() : super(NotificationState());

  Future<void> fetchNotifications() async {
    state = state.copyWith(isLoading: true);
    try {
      await Future.delayed(2.seconds);
      state = state.copyWith(notifications: [
        {
          'title': 'New Lead Assigned',
          'description':
              'A new lead "Acme Corporation" has been assigned to you.',
          'time': 'Recent',
        },
        {
          'title': 'Upcoming Meeting',
          'description':
              'Your meeting with "John Doe" is scheduled for tomorrow at 10:00 AM.',
          'time': 'Yesterday',
        },
        {
          'title': 'Task Completed',
          'description':
              'The task "Follow up with Acme Corp" has been marked as completed.',
          'time': '1 Month Ago',
        },
        {
          'title': 'Deal Closed',
          'description':
              'The deal "Acme Corp - \$50,000" has been successfully closed.',
          'time': 'Recent',
        },
        {
          'title': 'New Contact Added',
          'description':
              'A new contact "Jane Smith" has been added to the CRM.',
          'time': 'Recent',
        },
        {
          'title': 'Payment Received',
          'description':
              'Payment of \$10,000 has been received for the deal "Acme Corp".',
          'time': 'Yesterday',
        },
        {
          'title': 'Reminder: Follow Up',
          'description':
              'Follow up with "John Doe" regarding the pending proposal.',
          'time': '1 Month Ago',
        },
        {
          'title': 'New Opportunity',
          'description':
              'A new opportunity "Global Tech - \$100,000" has been created.',
          'time': 'Recent',
        },
        {
          'title': 'Account Updated',
          'description':
              'The account "Acme Corp" has been updated with new details.',
          'time': 'Yesterday',
        },
        {
          'title': 'Reminder: Renewal Due',
          'description':
              'The subscription renewal for "Acme Corp" is due in 7 days.',
          'time': '1 Month Ago',
        },
      ]);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final notificationStateProvider =
    StateNotifierProvider<NotificationStateNotifier, NotificationState>(
  (ref) => NotificationStateNotifier(),
);
