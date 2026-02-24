// lib/views/growth/growth_tracker_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../../models/child_model.dart';

class GrowthTrackerScreen extends StatelessWidget {
  final ChildModel child;
  const GrowthTrackerScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('${child.name}\'s Growth'),
        leading: const BackButton(),
        actions: [
          IconButton(icon: const Icon(Icons.add_circle_outline_rounded), onPressed: () => _showLogSheet(context)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Toggle
            Obx(() => Container(
              decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: ['Weight (kg)', 'Height (cm)'].asMap().entries.map((e) => Expanded(
                  child: GestureDetector(
                    onTap: () => controller.setGrowthToggle(e.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: controller.growthToggle.value == e.key ? AppColors.pink : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text(e.value, style: TextStyle(color: controller.growthToggle.value == e.key ? Colors.white : AppColors.textSecondary, fontWeight: FontWeight.w600))),
                    ),
                  ),
                )).toList(),
              ),
            )),
            const SizedBox(height: 20),
            // Stats Row
            Row(
              children: [
                Expanded(child: StatChip(label: 'Current', value: '${child.weightKg} kg', color: AppColors.pink, icon: Icons.monitor_weight_outlined)),
                const SizedBox(width: 10),
                Expanded(child: StatChip(label: 'Last Month', value: '18.2 kg', color: AppColors.blue, icon: Icons.history_rounded)),
                const SizedBox(width: 10),
                Expanded(child: StatChip(label: 'Change', value: '+0.3 kg', color: Colors.green, icon: Icons.trending_up_rounded)),
              ],
            ),
            const SizedBox(height: 20),
            // Chart
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Growth Chart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Text('Last 12 months', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 220,
                    child: Obx(() => LineChart(_buildChartData(controller.growthToggle.value))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Percentile card
            AppCard(
              color: AppColors.green,
              child: Row(
                children: [
                  const Text('📊', style: TextStyle(fontSize: 32)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('WHO Percentile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        const Text('Emma is in the 75th percentile for weight and 80th for height — above average! 🎉', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // History table
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Measurement History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Table(
                    columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(1.5), 2: FlexColumnWidth(1.5)},
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        children: ['Date', 'Weight', 'Height'].map((h) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                          child: Text(h, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        )).toList(),
                      ),
                      ...MockData.growthEntries.reversed.map((e) => TableRow(
                        children: [
                          Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6), child: Text('${e.date.month}/${e.date.year}', style: const TextStyle(fontSize: 13))),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6), child: Text('${e.weight} kg', style: const TextStyle(fontSize: 13))),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6), child: Text('${e.height} cm', style: const TextStyle(fontSize: 13))),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _buildChartData(int toggle) {
    final spots = MockData.growthEntries.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), toggle == 0 ? e.value.weight : e.value.height);
    }).toList();

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (_) => FlLine(color: AppColors.pink.withOpacity(0.1), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 38, getTitlesWidget: (v, _) => Text(v.toStringAsFixed(0), style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)))),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
          final months = ['Jan', 'Mar', 'May', 'Jul', 'Sep', 'Nov'];
          final i = v.toInt();
          if (i >= 0 && i < months.length) return Text(months[i], style: const TextStyle(fontSize: 11, color: AppColors.textSecondary));
          return const SizedBox();
        })),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: const LinearGradient(colors: [AppColors.pink, AppColors.blue]),
          barWidth: 3,
          dotData: FlDotData(
            getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(radius: 5, color: AppColors.pink, strokeColor: Colors.white, strokeWidth: 2),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(colors: [AppColors.pink.withOpacity(0.2), AppColors.blue.withOpacity(0.05)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
      ],
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
            const Text('Log Measurement', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            Row(children: [
              const Expanded(child: TextField(decoration: InputDecoration(labelText: 'Weight (kg)'))),
              const SizedBox(width: 12),
              const Expanded(child: TextField(decoration: InputDecoration(labelText: 'Height (cm)'))),
            ]),
            const SizedBox(height: 16),
            GradientButton(label: 'Save Entry', onTap: () => Get.back()),
          ],
        ),
      ),
    );
  }
}
