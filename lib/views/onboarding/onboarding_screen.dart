// lib/views/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/services/sharedpref_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final _pages = [
    _OnboardingData(
      emoji: '📈',
      title: 'Track Growth Milestones',
      subtitle: 'Monitor your child\'s height, weight, and development with beautiful charts and insights.',
      gradient: AppColors.gradient1,
      bg: AppColors.coral,
    ),
    _OnboardingData(
      emoji: '😴',
      title: 'Sleep & Activity Insights',
      subtitle: 'Log sleep patterns and daily activities to build the healthiest routines for your little ones.',
      gradient: AppColors.gradient3,
      bg: AppColors.green,
    ),
    _OnboardingData(
      emoji: '🤖',
      title: 'AI-Powered Guidance',
      subtitle: 'Get personalized health insights and tips powered by AI, tailored to each of your children.',
      gradient: AppColors.gradient2,
      bg: const Color(0xFFFFFDE7),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () => gotToLoginScreen(),
                  child: const Text('Skip', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.pink,
                      dotColor: AppColors.pink.withOpacity(0.3),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _currentPage == _pages.length - 1
                      ? GradientButton(
                          label: 'Get Started 🚀',
                          onTap: () => gotToLoginScreen(),
                        )
                      : AppButton(
                          label: 'Next',
                          onTap: () => _pageController.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeInOut),
                        ),
                  const SizedBox(height: 12),
                  if (_currentPage < _pages.length - 1)
                    TextButton(
                      onPressed: () => gotToLoginScreen(),
                      child: const Text('Already have an account? Login', style: TextStyle(color: AppColors.textSecondary)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


gotToLoginScreen()async{
  await SharedPrefService.saveIsSkipOnboarding();
  Get.off(() => const LoginScreen());
}

class _OnboardingData {
  final String emoji, title, subtitle;
  final LinearGradient gradient;
  final Color bg;
  const _OnboardingData({required this.emoji, required this.title, required this.subtitle, required this.gradient, required this.bg});
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;
  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: data.bg,
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(data.emoji, style: const TextStyle(fontSize: 90))),
          ),
          const SizedBox(height: 48),
          Text(data.title, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text(data.subtitle, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
