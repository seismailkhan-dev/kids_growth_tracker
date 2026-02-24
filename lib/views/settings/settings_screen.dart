// lib/views/settings/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../auth/login_screen.dart';
import '../subscription/subscription_screen.dart';

class SettingsScreen extends StatelessWidget {
  final bool embedded;
  const SettingsScreen({super.key, this.embedded = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: embedded ? null : const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile card
            AppCard(
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(gradient: AppColors.gradient1, shape: BoxShape.circle),
                    child: const Center(child: Text('👩', style: TextStyle(fontSize: 32))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sarah Johnson', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const Text('sarah@family.com', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                        const SizedBox(height: 6),
                        Obx(() => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            gradient: controller.isPremium.value ? AppColors.gradient2 : null,
                            color: controller.isPremium.value ? null : AppColors.pink.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            controller.isPremium.value ? '✨ Pro Member' : 'Free Plan',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: controller.isPremium.value ? Colors.white : AppColors.pink),
                          ),
                        )),
                      ],
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary), onPressed: () {}),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Upgrade card (if free)
            Obx(() => controller.isPremium.value
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () => Get.to(() => const SubscriptionScreen()),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        gradient: AppColors.gradient2,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Text('✨', style: TextStyle(fontSize: 28)),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Upgrade to Pro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                                Text('Unlock unlimited tracking & AI insights', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(10)),
                            child: const Text('Try Free', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ],
                      ),
                    ),
                  )),
            // App settings
            _section('Appearance', [
              _SettingTile(
                icon: Icons.dark_mode_outlined,
                label: 'Dark Mode',
                trailing: Obx(() => Switch(value: controller.isDarkMode.value, onChanged: (_) => controller.toggleTheme(), activeColor: AppColors.pink)),
              ),
            ]),
            _section('Notifications', [
              _SettingTile(
                icon: Icons.notifications_outlined,
                label: 'Push Notifications',
                trailing: Obx(() => Switch(value: controller.notificationsEnabled.value, onChanged: (v) => controller.notificationsEnabled.value = v, activeColor: AppColors.pink)),
              ),
              _SettingTile(
                icon: Icons.alarm_outlined,
                label: 'Reminders',
                trailing: Obx(() => Switch(value: controller.reminderEnabled.value, onChanged: (v) => controller.reminderEnabled.value = v, activeColor: AppColors.pink)),
              ),
              _SettingTile(
                icon: Icons.bar_chart_outlined,
                label: 'Weekly Reports',
                trailing: Obx(() => Switch(value: controller.weeklyReportEnabled.value, onChanged: (v) => controller.weeklyReportEnabled.value = v, activeColor: AppColors.pink)),
              ),
            ]),
            _section('Account', [
              _SettingTile(icon: Icons.lock_outline_rounded, label: 'Change Password', onTap: () {}),
              _SettingTile(icon: Icons.family_restroom_rounded, label: 'Family Members', onTap: () {}),
              _SettingTile(icon: Icons.privacy_tip_outlined, label: 'Privacy Settings', onTap: () {}),
              _SettingTile(icon: Icons.download_outlined, label: 'Export My Data', onTap: () {}),
            ]),
            _section('Support', [
              _SettingTile(icon: Icons.help_outline_rounded, label: 'Help Center', onTap: () {}),
              _SettingTile(icon: Icons.chat_bubble_outline_rounded, label: 'Contact Support', onTap: () {}),
              _SettingTile(icon: Icons.star_outline_rounded, label: 'Rate GrowthBuddy', onTap: () {}),
              _SettingTile(icon: Icons.info_outline_rounded, label: 'About', onTap: () {}),
            ]),
            const SizedBox(height: 8),
            AppButton(
              label: 'Sign Out',
              onTap: () =>controller.logoutUser(),
              isOutlined: true,
              color: AppColors.error,
              icon: Icons.logout_rounded,
            ),
            const SizedBox(height: 16),
            const Text('GrowthBuddy v1.0.0', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title.toUpperCase(), style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 12, letterSpacing: 1)),
        ),
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(children: tiles),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingTile({required this.icon, required this.label, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: AppColors.pink, size: 20),
      ),
      title: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
