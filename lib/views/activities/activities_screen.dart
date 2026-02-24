// lib/views/activities/activities_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../../models/child_model.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities & Routine'),
        leading: const BackButton(),
        actions: [IconButton(icon: const Icon(Icons.add_circle_outline_rounded), onPressed: () => _showAddSheet(context))],
      ),
      body: Obx(() {
        final completed = controller.activities.where((a) => a.isCompleted).length;
        final total = controller.activities.length;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Progress
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Today's Progress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('$completed/$total done', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: total > 0 ? completed / total : 0,
                              minHeight: 10,
                              backgroundColor: AppColors.pink.withOpacity(0.15),
                              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.pink),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('${((completed / total) * 100).toInt()}% of daily routine complete! ${completed == total ? "🎉" : "💪"}',
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SectionHeader(title: "Emma's Schedule", actionLabel: 'Edit'),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) {
                  final activity = controller.activities[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: _ActivityTile(activity: activity, onToggle: () => controller.toggleActivity(activity.id)),
                  );
                },
                childCount: controller.activities.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        );
      }),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: 'Activity Name', prefixIcon: Icon(Icons.add_task_rounded))),
            const SizedBox(height: 12),
            Row(children: [
              const Expanded(child: TextField(decoration: InputDecoration(labelText: 'Time', prefixIcon: Icon(Icons.access_time_rounded)))),
              const SizedBox(width: 12),
              const Expanded(child: TextField(decoration: InputDecoration(labelText: 'Duration', prefixIcon: Icon(Icons.timer_outlined)))),
            ]),
            const SizedBox(height: 20),
            GradientButton(label: 'Add Activity', onTap: () => Get.back()),
          ],
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final ActivityModel activity;
  final VoidCallback onToggle;
  const _ActivityTile({required this.activity, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          // Time indicator
          SizedBox(
            width: 48,
            child: Column(
              children: [
                Text(activity.time.split(' ')[0], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(activity.time.split(' ').length > 1 ? activity.time.split(' ')[1] : '', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              ],
            ),
          ),
          // Timeline dot
          Column(
            children: [
              Container(width: 1.5, height: 10, color: activity.color.withOpacity(0.3)),
              Container(width: 12, height: 12, decoration: BoxDecoration(color: activity.isCompleted ? activity.color : Colors.transparent, shape: BoxShape.circle, border: Border.all(color: activity.color, width: 2))),
              Container(width: 1.5, height: 10, color: activity.color.withOpacity(0.3)),
            ],
          ),
          const SizedBox(width: 14),
          // Emoji & info
          Text(activity.emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title, style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration: activity.isCompleted ? TextDecoration.lineThrough : null,
                  color: activity.isCompleted ? AppColors.textSecondary : null,
                )),
                Text(activity.duration, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          // Checkbox
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: activity.isCompleted ? activity.color : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: activity.color, width: 2),
              ),
              child: activity.isCompleted ? const Icon(Icons.check_rounded, size: 16, color: Colors.white) : null,
            ),
          ),
        ],
      ),
    );
  }
}
