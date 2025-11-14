// notification_repo.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String? timeLabel;
  final int? icon; // optional icon codepoint

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.timeLabel,
    this.icon,
  });
}

// Local/mock repository for now. Later replace with Dio/http calls.
final notificationRepoProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository.local();
});

class NotificationRepository {
  NotificationRepository.local();

  // Returns mock/empty data. Replace with API calls when ready.
  Future<List<NotificationItem>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Return empty list for now. You can return mock items if you want to preview UI.
    return <NotificationItem>[];
  }
}
