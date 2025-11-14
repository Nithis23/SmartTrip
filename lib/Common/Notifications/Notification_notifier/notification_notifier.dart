// notification_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Notification_repo/notification_repo.dart';


class NotificationState {
  final bool isLoading;
  final List<NotificationItem> notifications;

  const NotificationState({this.isLoading = false, this.notifications = const []});

  NotificationState copyWith({bool? isLoading, List<NotificationItem>? notifications}) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
    );
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  final repo = ref.read(notificationRepoProvider);
  return NotificationNotifier(repo);
});

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _repo;
  NotificationNotifier(this._repo) : super(const NotificationState());

  Future<void> loadNotifications() async {
    state = state.copyWith(isLoading: true);
    try {
      final list = await _repo.fetchNotifications();
      state = state.copyWith(isLoading: false, notifications: list);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

// add helpers to mark read / delete / refresh as needed later
}
