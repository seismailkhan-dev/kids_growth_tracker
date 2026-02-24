// lib/views/dashboard/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../../models/child_model.dart';
import '../child/child_profile_screen.dart';
import '../child/add_child_screen.dart';
import '../growth/growth_tracker_screen.dart';
import '../sleep/sleep_tracker_screen.dart';
import '../activities/activities_screen.dart';
import '../medical/medical_history_screen.dart';
import '../ai_insights/ai_insights_screen.dart';
import '../notifications/notifications_screen.dart';
import '../settings/settings_screen.dart';
import '../subscription/subscription_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;
  final controller = Get.find<AppController>();

  final _pages = <Widget>[
    const _HomeTab(),
    const _HomeTab(), // placeholder for Insights tab
    const _HomeTab(), // placeholder for Reports tab
    const _HomeTab(), // placeholder for Settings tab (redirected)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navIndex == 3
          ? const SettingsScreen(embedded: true)
          : _navIndex == 0
              ? const _HomeTab()
              : _navIndex == 1
                  ? const AiInsightsScreen(embedded: true)
                  : const _ReportsTab(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: AppColors.pink.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -4))],
      ),
      child: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), activeIcon: Icon(Icons.home_rounded, size: 28), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_outlined), activeIcon: Icon(Icons.auto_awesome, size: 28), label: 'AI Buddy'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart_rounded, size: 28), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings_rounded, size: 28), label: 'Settings'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context, controller)),
            SliverToBoxAdapter(child: _buildQuickStats(context)),
            SliverToBoxAdapter(child: _buildChildren(context, controller)),
            SliverToBoxAdapter(child: _buildQuickActions(context)),
            SliverToBoxAdapter(child: _buildTodaySummary(context, controller)),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good Morning! ☀️', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
                Text('${controller.userData.value?.firstName??''}\'s Family', style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
          ),
          Obx(() => Stack(
            children: [
              GestureDetector(
                onTap: () => Get.to(() => const NotificationsScreen()),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.pink.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications_outlined, color: AppColors.pink),
                ),
              ),
              if (controller.unreadCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                    child: Center(child: Text('${controller.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                  ),
                ),
            ],
          )),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => Get.to(() => const SubscriptionScreen()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(gradient: AppColors.gradient2, borderRadius: BorderRadius.circular(20)),
              child: const Text('PRO ✨', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.gradient1,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: AppColors.pink.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _statItem(context, '3', 'Children', '👨‍👩‍👧'),
            _divider(),
            _statItem(context, '5', 'Logs Today', '📝'),
            _divider(),
            _statItem(context, '10.4h', 'Avg Sleep', '😴'),
            _divider(),
            _statItem(context, '98%', 'Healthy', '❤️'),
          ],
        ),
      ),
    );
  }

  Widget _statItem(BuildContext context, String value, String label, String emoji) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
      ],
    );
  }

  Widget _divider() => Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3));

  Widget _buildChildren(BuildContext context, AppController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          SectionHeader(
            title: 'My Children',
            actionLabel: '+ Add Child',
            onAction: () => Get.to(() => const AddChildScreen()),
          ),
          const SizedBox(height: 14),
          ...MockData.children.map((child) => ChildCard(
            name: child.name,
            age: child.age,
            emoji: child.emoji,
            color: child.color,
            lastUpdated: '2 hours ago',
            onTap: () => Get.to(() => ChildProfileScreen(child: child)),
          )),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _QuickAction('Growth', Icons.show_chart_rounded, AppColors.pink, () => Get.to(() => GrowthTrackerScreen(child: MockData.children[0]))),
      _QuickAction('Sleep', Icons.bedtime_rounded, AppColors.blue, () => Get.to(() => const SleepTrackerScreen())),
      _QuickAction('Activities', Icons.directions_run_rounded, const Color(0xFF98FB98), () => Get.to(() => const ActivitiesScreen())),
      _QuickAction('Medical', Icons.medical_services_outlined, AppColors.coral, () => Get.to(() => const MedicalHistoryScreen())),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          const SectionHeader(title: 'Quick Actions'),
          const SizedBox(height: 14),
          Row(
            children: actions.map((a) => Expanded(
              child: GestureDetector(
                onTap: a.onTap,
                child: Container(
                  margin: EdgeInsets.only(right: actions.last == a ? 0 : 10),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: a.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: a.color.withOpacity(0.3)),
                  ),
                  child: Column(children: [
                    Icon(a.icon, color: a.color, size: 26),
                    const SizedBox(height: 6),
                    Text(a.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: a.color)),
                  ]),
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySummary(BuildContext context, AppController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          const SectionHeader(title: "Today's Summary"),
          const SizedBox(height: 14),
          AppCard(
            child: Column(
              children: [
                _summaryRow('💤', 'Emma slept 10.5 hrs', 'Excellent', Colors.green),
                const Divider(height: 20),
                _summaryRow('🍽️', 'Liam had all meals', 'On track', AppColors.blue),
                const Divider(height: 20),
                _summaryRow('🛝', 'Zoe\'s outdoor play', 'Pending', AppColors.yellow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String emoji, String text, String status, Color statusColor) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: statusColor.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
          child: Text(status, style: TextStyle(fontSize: 11, color: statusColor, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _ReportsTab extends StatelessWidget {
  const _ReportsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports & Insights')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _reportCard(context, '📊', 'Monthly Growth Report', 'Nov 2024', AppColors.pink),
            const SizedBox(height: 12),
            _reportCard(context, '😴', 'Sleep Analysis Report', 'Nov 2024', AppColors.blue),
            const SizedBox(height: 12),
            _reportCard(context, '🏃', 'Activity Summary', 'Nov 2024', const Color(0xFF98FB98)),
            const SizedBox(height: 12),
            _reportCard(context, '💊', 'Health & Medical Log', 'Nov 2024', AppColors.coral),
            const SizedBox(height: 12),
            _reportCard(context, '🧠', 'AI Insights Digest', 'Nov 2024', AppColors.yellow),
          ],
        ),
      ),
    );
  }

  Widget _reportCard(BuildContext context, String emoji, String title, String period, Color color) {
    return AppCard(
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(period, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            children: [
              Icon(Icons.download_rounded, color: color),
              const SizedBox(height: 4),
              Icon(Icons.share_rounded, color: color.withOpacity(0.6), size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickAction {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _QuickAction(this.label, this.icon, this.color, this.onTap);
  bool operator ==(Object other) => other is _QuickAction && other.label == label;
  @override int get hashCode => label.hashCode;
}
