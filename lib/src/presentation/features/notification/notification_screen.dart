import '../dashboard/subscreens/profile/profile.dart';
import 'state/notification_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notifications when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ref = ProviderScope.containerOf(context);
      ref.read(notificationStateProvider.notifier).fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Texts.notification),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final notificationState = ref.watch(notificationStateProvider);
          if (notificationState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final notifications = notificationState.notifications;
          return ListView.separated(
            separatorBuilder: (context, index) {
              return 15.hBox;
            },
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return _NotificationItem(notification: notification);
            },
          );
        },
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final Map<String, dynamic> notification;

  const _NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? CColors.darkContainer : CColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff565992).withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor:
              isDark ? CColors.darkContainer : Colors.blue.shade100,
          child: Icon(Icons.notifications,
              color: isDark ? CColors.white : Colors.blue),
        ),
        title: Text(
          notification['title'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification['description']),
            const SizedBox(height: 8),
            Text(
              notification['time'],
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
