// lib/views/subscription/subscription_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            height: 300,
            decoration: const BoxDecoration(gradient: AppColors.gradient2),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                          child: const Icon(Icons.close_rounded, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Text('✨', style: TextStyle(fontSize: 52)),
                      const SizedBox(height: 8),
                      const Text('GrowthBuddy Pro', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Unlock everything for your family\'s health journey', style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 14), textAlign: TextAlign.center),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Features
                          ..._features.map((f) => _FeatureRow(emoji: f[0], title: f[1], subtitle: f[2])),
                          const SizedBox(height: 24),
                          // Plan selector
                          Obx(() => Column(
                            children: [
                              _PlanCard(
                                label: 'Monthly',
                                price: '\$4.99/mo',
                                isSelected: controller.selectedPlan.value == 'monthly',
                                onTap: () => controller.setPlan('monthly'),
                              ),
                              const SizedBox(height: 12),
                              _PlanCard(
                                label: 'Yearly',
                                price: '\$39.99/yr',
                                badge: 'Save 33%',
                                isSelected: controller.selectedPlan.value == 'yearly',
                                onTap: () => controller.setPlan('yearly'),
                              ),
                            ],
                          )),
                          const SizedBox(height: 28),
                          GradientButton(
                            label: 'Start Free 7-Day Trial',
                            onTap: () {
                              controller.activatePremium();
                              Get.back();
                              Get.snackbar('Welcome to Pro! ✨', 'Your 7-day free trial has started', backgroundColor: AppColors.yellow, colorText: AppColors.textPrimary, borderRadius: 12, margin: const EdgeInsets.all(16));
                            },
                            gradient: AppColors.gradient2,
                          ),
                          const SizedBox(height: 12),
                          const Text('Cancel anytime. No commitments.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: ['Restore Purchase', ' · ', 'Privacy Policy', ' · ', 'Terms'].map((t) => Text(t, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11))).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _features = [
    ['📊', 'Advanced Growth Charts', 'WHO percentile tracking & detailed analytics'],
    ['🤖', 'Unlimited AI Insights', 'Personalized health tips & development analysis'],
    ['👨‍👩‍👧', 'Unlimited Children', 'Track all your kids in one place'],
    ['📄', 'PDF Health Reports', 'Export & share with your pediatrician'],
    ['🔔', 'Smart Reminders', 'Vaccine, checkup & milestone alerts'],
    ['☁️', 'Cloud Backup', 'Never lose your precious health data'],
  ];
}

class _FeatureRow extends StatelessWidget {
  final String emoji, title, subtitle;
  const _FeatureRow({required this.emoji, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: Colors.green, size: 22),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String label, price;
  final String? badge;
  final bool isSelected;
  final VoidCallback onTap;
  const _PlanCard({required this.label, required this.price, this.badge, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.pink.withOpacity(0.08) : null,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppColors.pink : Colors.grey.withOpacity(0.3), width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.pink : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? AppColors.pink : Colors.grey.withOpacity(0.5), width: 2),
              ),
              child: isSelected ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
            if (badge != null)
              Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.circular(8)),
                child: Text(badge!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87)),
              ),
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.pink)),
          ],
        ),
      ),
    );
  }
}
