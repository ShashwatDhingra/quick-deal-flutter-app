import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationServices.instance.setupFlutterNotifications();
  await NotificationServices.instance.showNotification(message);
}

class NotificationServices {
  NotificationServices._();

  static final NotificationServices instance = NotificationServices._();

  static const generalNotificationChannelId = 'general_notification';
  static const generalNotificationChannelName = 'General Notification';

  final _messaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();

  bool _isFirebaseNotificationInitialized = false;

  /// Initializes Firebase Messaging and Notification Handlers
  Future<void> initialize() async {
    // GlobalServerKey().getServerKey();
    // print("Initializing Firebase and Notifications...");

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request Permission for Notifications
    await _requestPermission();

    // Setup Message Handlers for Notifications
    await _setupMessageHandlers();
  }

  /// Requests permission for push notifications
  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('Permission Status: ${settings.authorizationStatus}');
  }

  /// Sets up Flutter Local Notifications
  Future<void> setupFlutterNotifications() async {
    if (_isFirebaseNotificationInitialized) return;

    if (kDebugMode) {
      print("Setting up Flutter Local Notifications...");
    }

    // Android-specific channel setup
    const androidChannel = AndroidNotificationChannel(
      generalNotificationChannelId,
      generalNotificationChannelName,
      description: 'This channel is used for general notifications.',
      importance: Importance.high,
    );

    await _localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    // Initialization settings for Android
    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidInitSettings);

    // Initialize Flutter Local Notifications with response handling
    await _localNotification.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          if (kDebugMode) {
            print("Notification clicked with payload: ${response.payload}");
          }
          // Convert payload string back to map for handling
          _handleNotificationPayload(
              jsonDecode(response.payload!) as Map<String, dynamic>);
        }
      },
    );

    _isFirebaseNotificationInitialized = true;
  }

  /// Shows a notification
  Future<void> showNotification(RemoteMessage message) async {
    if (!_isFirebaseNotificationInitialized) {
      await setupFlutterNotifications();
    }

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            generalNotificationChannelId,
            generalNotificationChannelName,
          ),
        ),
        payload: jsonEncode(message.data), // Pass message data as a JSON string
      );
    }
  }

  /// Sets up message handlers for foreground, background, and terminated states
  Future<void> _setupMessageHandlers() async {
    // Foreground Notifications
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // Background Notifications (App in background, notification tapped)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationClick);

    // Terminated Notifications
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationClick(initialMessage);
    }
  }

  /// Handles notification click for background and terminated states
  void _handleNotificationClick(RemoteMessage message) {
    if (kDebugMode) {
      print("Notification clicked: ${message.data}");
    }
    _handleNotificationPayload(message.data); // Passing the map directly
  }

  /// Handles payload from a clicked notification
  void _handleNotificationPayload(Map<String, dynamic> payload) {
    try {
      if (kDebugMode) {
        print("Processing notification payload: $payload");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error handling notification payload: ${e.toString()}");
      }
    }
  }
}
