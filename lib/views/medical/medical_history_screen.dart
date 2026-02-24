// lib/views/medical/medical_history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../../models/child_model.dart';

class MedicalHistoryScreen extends StatelessWidget {
  const MedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final filters = ['All', 'Checkup', 'Vaccination', 'Lab', 'Visit'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History'),
        leading: const BackButton(),
        actions: [IconButton(icon: const Icon(Icons.add_circle_outline_rounded), onPressed: () => _showAddSheet(context))],
      ),
      body: Column(
        children: [
          // Child selector
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: MockData.children.map((c) => Obx(() => GestureDetector(
                  onTap: () => controller.selectChild(MockData.children.indexOf(c)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: controller.selectedChild.id == c.id ? c.color : c.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${c.emoji} ${c.name.split(' ')[0]}', style: TextStyle(fontWeight: FontWeight.w600, color: controller.selectedChild.id == c.id ? Colors.white : AppColors.textSecondary)),
                  ),
                ))).toList(),
              ),
            ),
          ),
          // Filter chips
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Obx(() => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((f) => GestureDetector(
                  onTap: () => controller.setMedicalFilter(f),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: controller.selectedMedicalFilter.value == f ? AppColors.pink : AppColors.pink.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(f, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: controller.selectedMedicalFilter.value == f ? Colors.white : AppColors.textSecondary)),
                  ),
                )).toList(),
              ),
            )),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              final filter = controller.selectedMedicalFilter.value;
              final records = filter == 'All' ? MockData.medicalRecords : MockData.medicalRecords.where((r) => r.type == filter).toList();
              if (records.isEmpty) {
                return const EmptyStateWidget(emoji: '🏥', title: 'No records found', subtitle: 'No medical records match this filter yet.');
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: records.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _MedicalCard(record: records[i]),
              );
            }),
          ),
          // Upload area
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.pink, width: 1.5, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.pink.withOpacity(0.05),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.cloud_upload_outlined, color: AppColors.pink, size: 28),
                    SizedBox(height: 6),
                    Text('Upload Medical Document', style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.w600)),
                    Text('PDF, JPG, PNG supported', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
            const Text('Add Medical Record', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: 'Title', prefixIcon: Icon(Icons.medical_services_outlined))),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Doctor / Hospital', prefixIcon: Icon(Icons.person_outline_rounded))),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Date', prefixIcon: Icon(Icons.calendar_today_outlined))),
            const SizedBox(height: 12),
            const TextField(maxLines: 3, decoration: InputDecoration(labelText: 'Notes', prefixIcon: Icon(Icons.notes_rounded))),
            const SizedBox(height: 20),
            GradientButton(label: 'Save Record', onTap: () => Get.back()),
          ],
        ),
      ),
    );
  }
}

class _MedicalCard extends StatelessWidget {
  final MedicalRecord record;
  const _MedicalCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final typeColors = {
      'Checkup': AppColors.blue,
      'Vaccination': AppColors.pink,
      'Lab': AppColors.yellow,
      'Visit': AppColors.coral,
    };
    final color = typeColors[record.type] ?? AppColors.pink;

    return AppCard(
      onTap: () => _showDetail(context),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(record.emoji, style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 2),
                Text(record.doctor, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                  child: Text(record.type, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 11)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${record.date.day}/${record.date.month}/${record.date.year}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              const SizedBox(height: 8),
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondary),
            ],
          ),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(record.emoji, style: const TextStyle(fontSize: 36)),
              const SizedBox(width: 12),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(record.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(record.type, style: const TextStyle(color: AppColors.textSecondary)),
                ],
              )),
            ]),
            const Divider(height: 24),
            _detail('Doctor', record.doctor),
            _detail('Date', '${record.date.day}/${record.date.month}/${record.date.year}'),
            _detail('Notes', record.notes),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: AppButton(label: 'Share', onTap: () {}, isOutlined: true, icon: Icons.share_rounded)),
              const SizedBox(width: 12),
              Expanded(child: AppButton(label: 'Download', onTap: () {}, icon: Icons.download_rounded)),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _detail(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    ),
  );
}
