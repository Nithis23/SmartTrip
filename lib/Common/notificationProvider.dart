import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartrip/firebase_options.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  // Initialize everything
  Future<void> initialize() async {
    await _requestPermission();
    await _initLocalNotification();
    await _configureFirebaseListeners();
  }

  // Ask for notification permissions
  Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    print("🔔 Permission Status = ${settings.authorizationStatus}");
  }

  // Initialize Local Notification System
  Future<void> _initLocalNotification() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        print("📌 Local notification clicked → ${details.payload}");
      },
    );

    // Android notification channel
    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            'high_channel',
            'High Priority',
            importance: Importance.max,
          ),
        );
  }

  // Show local notification
  Future<void> _showLocal(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'high_channel',
      'High Priority',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails();

    await _local.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: message.data.toString(),
    );
  }

  Future<void> showTestNotification() async {
    await _requestPermission();
    const androidDetails = AndroidNotificationDetails(
      'high_channel',
      'High Priority',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    // await Future.delayed(Duration(seconds: 5));

    await _local.show(
      DateTime.now().millisecond, // unique ID
      "Test Notification",
      "This is triggered manually from button",
      details,
    );
  }

  // Firebase listeners
  Future<void> _configureFirebaseListeners() async {
    // FCM token
    String? token = await _messaging.getToken();
    print("🔑 FCM Token: $token");

    // Foreground notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📨 Foreground message → ${message.data}");
      _showLocal(message);
    });

    // When tapped notification & app in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📌 Notification clicked (background) → ${message.data}");
      _showLocal(message);
    });

    // When app closed & opened via notification
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("🚀 Notification clicked (terminated) → ${initialMessage.data}");
    }
  }
}

// ----------------------------------------------------------------------
// RIVERPOD PROVIDER
// ----------------------------------------------------------------------
final notificationFCMProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

// ----------------------------------------------------------------------
// BACKGROUND HANDLER — MUST BE TOP LEVEL
// ----------------------------------------------------------------------
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase for background isolate
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("🌙 Background Message: ${message.data}");
  print("🌙 Background Notification: ${message.notification?.title}");

  // Initialize Local Notifications
  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  const InitializationSettings settings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );

  await plugin.initialize(settings);

  // Android notification details
  const androidDetails = AndroidNotificationDetails(
    'high_channel',
    'High Priority Notifications',
    channelDescription: 'Used for important notifications',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  // iOS notification details
  const iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // Display the notification
  await plugin.show(
    message.hashCode,
    message.notification?.title ?? '',
    message.notification?.body ?? '',
    const NotificationDetails(android: androidDetails, iOS: iosDetails),
  );
}
