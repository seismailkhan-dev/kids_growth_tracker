// lib/views/splash/splash_screen.dart
import 'package:family_health_tracker/controllers/app_controller.dart';
import 'package:family_health_tracker/core/services/sharedpref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6)));
    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () {
     final appController = Get.find<AppController>();
     appController.checkUserSession();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.gradient1),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => FadeTransition(
            opacity: _fadeAnim,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.4), blurRadius: 30, spreadRadius: 5)],
                      ),
                      child: const Center(child: Text('🌱', style: TextStyle(fontSize: 60))),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text('GrowthBuddy', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Text('Track Every Precious Moment', style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.85))),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
