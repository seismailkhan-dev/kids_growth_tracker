// lib/views/auth/login_screen.dart
import 'package:family_health_tracker/core/services/validation_service.dart';
import 'package:family_health_tracker/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final authController = Get.put(AuthController());

  final _validation = GlobalKey<FormState>();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _validation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradient1,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: AppColors.pink.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 6))],
                    ),
                    child: const Center(child: Text('🌱', style: TextStyle(fontSize: 38))),
                  ),
                ),
                const SizedBox(height: 32),
                Text('Welcome Back! 👋', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text('Sign in to continue tracking your little ones', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 36),
                CustomTextField(
                    onValidator: ValidationService.validateEmail,
                    label: 'Email Address',
                    prefix: const Icon(Icons.mail_outline_rounded),
                    hint: 'Enter Email', controller: authController.emailController),

                const SizedBox(height: 20),

                Obx((){
                    return CustomTextField(
                      onValidator: ValidationService.validatePassword,
                        label: 'Password',
                      obscureText: authController.isObscureText.value,
                        prefix: const Icon(Icons.lock_outline_rounded),
                        suffix: GestureDetector(
                          onTap: () => authController.changeObscure(),
                          child:Icon(authController.isObscureText.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        ),
                        hint: 'Enter Password', controller: authController.passwordController);
                  }
                ),

                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.to(() => const ForgotPasswordScreen()),
                    child: const Text('Forgot Password?', style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 24),
                Obx((){
                    return GradientButton(label: authController.isLoading.value ? 'Signing in...' :
                    'Sign In', onTap: authController.isLoading.value ? () {} : (){
                      if(_validation.currentState?.validate()??false){
                        authController.loginUser();
                      }

                    }, icon: Icons.login_rounded);
                  }
                ),
                const SizedBox(height: 16),
                _buildDivider(),
                const SizedBox(height: 16),
                _buildSocialButton('Continue with Google', '🇬', Colors.white),
                const SizedBox(height: 12),
                _buildSocialButton('Continue with Apple', '🍎', Colors.black, textColor: Colors.white),
                const SizedBox(height: 32),
                Center(
                  child: GestureDetector(
                    onTap: () => Get.to(() => const SignupScreen()),
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                        children: [TextSpan(text: 'Sign Up', style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.w700))],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildDivider() => Row(children: [
    Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
    const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('OR', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500))),
    Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
  ]);

  Widget _buildSocialButton(String label, String icon, Color bg, {Color textColor = const Color(0xFF2D2D2D)}) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 15)),
      ]),
    );
  }
}
