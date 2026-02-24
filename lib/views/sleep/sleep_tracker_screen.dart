// lib/views/sleep/sleep_tracker_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../../models/child_model.dart';

class SleepTrackerScreen extends StatelessWidget {
  const SleepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final child = MockData.children[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Tracker'),
        leading: const BackButton(),
        actions: [IconButton(icon: const Icon(Icons.add_circle_outline_rounded), onPressed: () => _showLogSheet(context))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Child selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: MockData.children.asMap().entries.map((e) => Obx(() => GestureDetector(
                  onTap: () => controller.selectChild(e.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: controller.selectedChildIndex.value == e.key ? e.value.color : e.value.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(children: [
                      Text(e.value.emoji, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(e.value.name.split(' ')[0], style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: controller.selectedChildIndex.value == e.key ? Colors.white : AppColors.textSecondary,
                      )),
                    ]),
                  ),
                ))).toList(),
              ),
            ),
            const SizedBox(height: 20),
            // Tonight's target
            AppCard(
              color: AppColors.blue.withOpacity(0.15),
              child: Row(
                children: [
                  const Text('🌙', style: TextStyle(fontSize: 36)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tonight\'s Goal', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('Recommended: 10–13 hours for ${child.age}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),
                  ),
                  const Text('10–13h', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Weekly chart
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('This Week', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text('Average: 10.4 hours/night', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 160,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 14,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
                            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                            return Text(days[v.toInt()], style: const TextStyle(fontSize: 11, color: AppColors.textSecondary));
                          })),
                        ),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: MockData.sleepEntries.asMap().entries.map((e) => BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: e.value.hoursSlept,
                              gradient: LinearGradient(
                                colors: [AppColors.blue, AppColors.blue.withOpacity(0.4)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              width: 28,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                            ),
                          ],
                        )).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Timeline
            const SectionHeader(title: 'Sleep Timeline'),
            const SizedBox(height: 14),
            ...MockData.sleepEntries.reversed.take(5).map((entry) => _sleepEntry(context, entry)),
          ],
        ),
      ),
    );
  }

  Widget _sleepEntry(BuildContext context, SleepEntry entry) {
    final Color qualityColor = entry.quality == 'Great' ? Colors.green : entry.quality == 'Good' ? AppColors.blue : AppColors.yellow;
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final dayLabel = days[entry.date.weekday - 1];

    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(color: AppColors.blue.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              const Text('🌙', style: TextStyle(fontSize: 16)),
              Text(dayLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${entry.bedTime.format(context)} → ${entry.wakeTime.format(context)}', style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('${entry.hoursSlept} hours slept', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: qualityColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                child: Text(entry.quality, style: TextStyle(color: qualityColor, fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogSheet(BuildContext context) {
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
            const Text('Log Sleep', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            Row(children: [
              const Expanded(child: TextField(decoration: InputDecoration(labelText: 'Bedtime', prefixIcon: Icon(Icons.bedtime_outlined)))),
              const SizedBox(width: 12),
              const Expanded(child: TextField(decoration: InputDecoration(labelText: 'Wake Time', prefixIcon: Icon(Icons.wb_sunny_outlined)))),
            ]),
            const SizedBox(height: 16),
            const Text('Sleep Quality', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(children: ['Fair', 'Good', 'Great'].map((q) => Expanded(
              child: Container(
                margin: EdgeInsets.only(right: q != 'Great' ? 8 : 0),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: AppColors.blue.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text(q, style: const TextStyle(fontWeight: FontWeight.w500))),
              ),
            )).toList()),
            const SizedBox(height: 20),
            GradientButton(label: 'Save Sleep Log', onTap: () => Get.back(), gradient: AppColors.gradient3),
          ],
        ),
      ),
    );
  }
}
