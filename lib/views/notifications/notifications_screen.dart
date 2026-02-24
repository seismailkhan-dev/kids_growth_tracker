// lib/views/notifications/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: const BackButton(),
        actions: [
          TextButton(
            onPressed: controller.markAllRead,
            child: const Text('Mark all read', style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const EmptyStateWidget(emoji: '🔔', title: 'No notifications', subtitle: 'You\'re all caught up! We\'ll notify you when something needs attention.');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            final n = controller.notifications[i];
            return AppCard(
              color: n['isRead'] == true ? null : AppColors.pink.withOpacity(0.05),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: n['isRead'] == true ? Colors.grey.withOpacity(0.1) : AppColors.pink.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text(n['emoji'], style: const TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(n['title'], style: TextStyle(fontWeight: FontWeight.w600, color: n['isRead'] == true ? AppColors.textSecondary : null)),
                        const SizedBox(height: 2),
                        Text(n['subtitle'], style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(n['time'], style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                      ],
                    ),
                  ),
                  if (n['isRead'] == false)
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.pink, shape: BoxShape.circle)),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
