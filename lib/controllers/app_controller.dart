// lib/controllers/app_controller.dart
import 'package:family_health_tracker/models/user.dart';
import 'package:family_health_tracker/views/auth/login_screen.dart';
import 'package:family_health_tracker/views/dashboard/dashboard_screen.dart';
import 'package:family_health_tracker/views/onboarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/services/drift_service.dart';
import '../core/services/firebase_service.dart';
import '../core/services/sharedpref_service.dart';
import '../core/services/sync_service.dart';
import '../models/child_model.dart';

class AppController extends GetxController {

  final FirebaseService _firebase = FirebaseService();
  final DriftService _drift = DriftService();
  late final SyncService _sync;


  // Theme
  final isDarkMode = false.obs;
  final isPremium = false.obs;

  Rxn<UserModel> userData = Rxn<UserModel>();


  @override
  void onInit() {
    super.onInit();
    _sync = SyncService(firebase: _firebase, drift: _drift);
  }


  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }




  Future<void> checkUserSession() async {
    final bool isLoggedIn = SharedPrefService.getIsLoggedIn();
    final bool isSkipOnboarding = SharedPrefService.getIsSkipOnboarding();

    if (!isLoggedIn) {
      Get.offAll(() =>
      isSkipOnboarding ? const LoginScreen() : const OnboardingScreen());
      return;
    }

    final localUser = await _drift.getLastLoggedInUser();

    if (localUser == null) {
      // corrupted session → force login
      SharedPrefService.clear();
      Get.offAll(() => const LoginScreen());
      return;
    }

    // ✅ Set user instantly
    userData.value = localUser;
    isPremium.value = localUser.isPremiumUser;

    // ✅ Navigate immediately (offline-safe)
    Get.offAll(() => const DashboardScreen());

    // 🔄 Background sync (does NOT block UI)
    _backgroundSync(localUser);
  }

  Future<void> _backgroundSync(UserModel localUser) async {
    if (!await _sync.isOnline) return;

    try {
      // 1️⃣ Ensure Firebase Auth session (silent)
      await _firebase.ensureSignedInFromCache();

      // 2️⃣ Pull latest user profile
      final remoteUser = await _firebase.fetchUser(localUser.id);
      if (remoteUser != null) {
        await _drift.saveUser(
          localUser.copyWith(
            name: remoteUser['name'],
            isPremiumUser: remoteUser['isPremiumUser'],
            updatedAt: DateTime.now(),
            isSynced: true,
          ),
        );
      }

      // 3️⃣ Push local unsynced data
      await _sync.syncPendingData(localUser.id);

      // 4️⃣ Pull remote changes (children, growth, etc.)
      // await _sync.pullRemoteUpdates(userId);
    } catch (e) {
      debugPrint('Background sync failed: $e');
    }
  }


  logoutUser() async {
    await FirebaseAuth.instance.signOut();
    SharedPrefService.clear();
    userData.value =null;
    isPremium.value = false;
    isDarkMode.value = false;

    Get.offAll(()=> const LoginScreen());


  }



  // Selected child
  final selectedChildIndex = 0.obs;

  ChildModel get selectedChild => MockData.children[selectedChildIndex.value];

  void selectChild(int index) => selectedChildIndex.value = index;

  // Dashboard tab
  final dashboardTabIndex = 0.obs;
  void setDashboardTab(int i) => dashboardTabIndex.value = i;

  // Growth toggle (weight / height)
  final growthToggle = 0.obs;
  void setGrowthToggle(int i) => growthToggle.value = i;

  // Sleep view toggle
  final sleepViewToggle = 0.obs;
  void setSleepViewToggle(int i) => sleepViewToggle.value = i;

  // AI chat input
  final chatMessages = <Map<String, dynamic>>[].obs;
  final isAiTyping = false.obs;

  void initChat() {
    chatMessages.value = List<Map<String, dynamic>>.from(MockData.aiMessages);
  }

  void sendMessage(String text) {
    chatMessages.add({'role': 'user', 'text': text});
    isAiTyping.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      chatMessages.add({'role': 'assistant', 'text': 'That\'s a great question! Based on the latest data for your child, everything looks healthy and on track. Keep maintaining the current routine and don\'t hesitate to consult your pediatrician for any specific concerns. 💙'});
      isAiTyping.value = false;
    });
  }

  // Notifications
  final notifications = MockData.notifications.obs;

  void markAllRead() {
    notifications.value = notifications.map((n) => {...n, 'isRead': true}).toList();
  }

  int get unreadCount => notifications.where((n) => n['isRead'] == false).length;

  // Activities
  final activities = MockData.activities.obs;

  void toggleActivity(String id) {
    final index = activities.indexWhere((a) => a.id == id);
    if (index != -1) {
      final a = activities[index];
      activities[index] = ActivityModel(
        id: a.id, title: a.title, emoji: a.emoji, time: a.time,
        duration: a.duration, color: a.color, isCompleted: !a.isCompleted,
      );
    }
  }

  // Medical records type filter
  final selectedMedicalFilter = 'All'.obs;
  void setMedicalFilter(String f) => selectedMedicalFilter.value = f;

  // Settings
  final notificationsEnabled = true.obs;
  final reminderEnabled = true.obs;
  final weeklyReportEnabled = false.obs;

  // Subscription
  final selectedPlan = 'monthly'.obs;
  void setPlan(String plan) => selectedPlan.value = plan;
  void activatePremium() => isPremium.value = true;
}
