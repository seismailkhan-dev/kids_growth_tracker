// lib/views/child/child_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../../models/child_model.dart';
import '../growth/growth_tracker_screen.dart';
import '../sleep/sleep_tracker_screen.dart';
import '../medical/medical_history_screen.dart';

class ChildProfileScreen extends StatefulWidget {
  final ChildModel child;
  const ChildProfileScreen({super.key, required this.child});

  @override
  State<ChildProfileScreen> createState() => _ChildProfileScreenState();
}

class _ChildProfileScreenState extends State<ChildProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _editMode = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.child;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            leading: const BackButton(),
            actions: [
              IconButton(
                icon: Icon(_editMode ? Icons.check_rounded : Icons.edit_outlined),
                onPressed: () => setState(() => _editMode = !_editMode),
              ),
              IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () => _showOptions()),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [child.color.withOpacity(0.3), child.color.withOpacity(0.1)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(color: child.color.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: child.color, width: 3)),
                            child: Center(child: Text(child.emoji, style: const TextStyle(fontSize: 44))),
                          ),
                          if (_editMode)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(color: AppColors.pink, shape: BoxShape.circle),
                              child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(child.name, style: Theme.of(context).textTheme.headlineMedium),
                      Text(child.age, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.pink,
              labelColor: AppColors.pink,
              unselectedLabelColor: AppColors.textSecondary,
              tabs: const [Tab(text: 'Overview'), Tab(text: 'Stats'), Tab(text: 'Medical')],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _OverviewTab(child: child, editMode: _editMode),
            _StatsTab(child: child),
            _MedicalTab(child: child),
          ],
        ),
      ),
    );
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _option(Icons.share_rounded, 'Share Profile'),
            _option(Icons.download_rounded, 'Export Data'),
            _option(Icons.delete_outline_rounded, 'Remove Child', color: AppColors.error),
          ],
        ),
      ),
    );
  }

  Widget _option(IconData icon, String label, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textPrimary),
      title: Text(label, style: TextStyle(color: color)),
      onTap: () => Get.back(),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  final ChildModel child;
  final bool editMode;
  const _OverviewTab({required this.child, required this.editMode});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Basic Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 14),
                _infoRow(context, 'Date of Birth', '${child.birthDate.day}/${child.birthDate.month}/${child.birthDate.year}', editMode),
                _infoRow(context, 'Gender', child.gender, editMode),
                _infoRow(context, 'Blood Type', child.bloodType, editMode),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Allergies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...child.allergies.map((a) => Chip(
                      label: Text(a),
                      backgroundColor: AppColors.coral,
                      deleteIcon: editMode ? const Icon(Icons.close, size: 14) : null,
                      onDeleted: editMode ? () {} : null,
                    )),
                    if (editMode)
                      ActionChip(
                        label: const Text('+ Add'),
                        backgroundColor: AppColors.pink.withOpacity(0.15),
                        onPressed: () {},
                      ),
                    if (child.allergies.isEmpty && !editMode)
                      const Text('No known allergies ✅', style: TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (editMode)
            GradientButton(label: 'Save Changes', onTap: () {}),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value, bool editMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13))),
          Expanded(
            flex: 3,
            child: editMode
                ? TextFormField(initialValue: value, decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)))
                : Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _StatsTab extends StatelessWidget {
  final ChildModel child;
  const _StatsTab({required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: StatChip(label: 'Weight', value: '${child.weightKg} kg', color: AppColors.pink, icon: Icons.monitor_weight_outlined)),
              const SizedBox(width: 12),
              Expanded(child: StatChip(label: 'Height', value: '${child.heightCm} cm', color: AppColors.blue, icon: Icons.height_rounded)),
              const SizedBox(width: 12),
              Expanded(child: StatChip(label: 'BMI', value: (child.weightKg / ((child.heightCm / 100) * (child.heightCm / 100))).toStringAsFixed(1), color: AppColors.yellow, icon: Icons.analytics_outlined)),
            ],
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quick Links', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                _quickLink(context, '📈', 'View Growth Chart', () => Get.to(() => GrowthTrackerScreen(child: child))),
                _quickLink(context, '😴', 'Sleep History', () => Get.to(() => const SleepTrackerScreen())),
                _quickLink(context, '🩺', 'Medical Records', () => Get.to(() => const MedicalHistoryScreen())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickLink(BuildContext context, String emoji, String label, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(emoji, style: const TextStyle(fontSize: 24)),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
      onTap: onTap,
    );
  }
}

class _MedicalTab extends StatelessWidget {
  final ChildModel child;
  const _MedicalTab({required this.child});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: MockData.medicalRecords.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final record = MockData.medicalRecords[i];
        return AppCard(
          child: Row(children: [
            Text(record.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(record.doctor, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            )),
            Text('${record.date.day}/${record.date.month}/${record.date.year}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ]),
        );
      },
    );
  }
}
