import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartrip/utils/theme.dart';

import 'Notification_notifier/notification_notifier.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Inbox', style: AppTheme.headingStyle),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.notifications.isEmpty
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // filters row matches your screenshot's look (keeps UI)
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sort),
                  label: const Text('Sort'),
                  style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.grey.shade100, foregroundColor: Colors.black),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Newest'),
                  style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.grey.shade100, foregroundColor: Colors.black),
                ),
                const Spacer(),
                // three dot menu stub
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Text(
                  'No alerts or messages at this time',
                  style: AppTheme.bodycontentStyle,
                ),
              ),
            ),
          ],
        )
            : ListView.separated(
          itemCount: state.notifications.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final n = state.notifications[index];
            return ListTile(
              leading: Icon((n.icon ?? Icons.notifications) as IconData?),
              title: Text(n.title),
              subtitle: Text(n.body),
              trailing: Text(n.timeLabel ?? ''),
              onTap: () {

              },
            );
          },
        ),
      ),
    );
  }
}
