// lib/views/auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../core/services/validation_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../../core/widgets/custom_checkbox.dart';
import '../../core/widgets/custom_text_field.dart';
import '../dashboard/dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Obx((){
              return Form(
                key: _validation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create Account 🎉', style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 8),
                    Text('Join thousands of families on GrowthBuddy', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
                    const SizedBox(height: 32),
                    Row(children: [

                      Expanded(
                        child: CustomTextField(
                            onValidator: ValidationService.validateFirstName,
                            prefix: const Icon(Icons.person_outline_rounded),
                            hint: 'First Name', controller: authController.firstNameController),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: CustomTextField(
                            onValidator: ValidationService.validateLastName,
                            prefix: const Icon(Icons.person_outline_rounded),
                            hint: 'Last Name', controller: authController.lastNameController),
                      ),

                    ]),
                    const SizedBox(height: 16),
                    CustomTextField(
                        onValidator: ValidationService.validateEmail,
                        prefix: const Icon(Icons.mail_outline_rounded),
                        hint: 'Email Address', controller: authController.emailController),

                    const SizedBox(height: 16),
                    CustomTextField(
                      keyboardType: TextInputType.phone,
                        onValidator: ValidationService.validatePhone,
                        prefix: const Icon(Icons.phone_outlined),
                        hint: 'Phone Number', controller: authController.phoneController),

                    const SizedBox(height: 16),
                    Obx((){
                        return CustomTextField(
                            onValidator: ValidationService.validatePassword,
                            obscureText: authController.isObscureText.value,
                            prefix: const Icon(Icons.lock_outline_rounded),
                            suffix: GestureDetector(
                              onTap: () => authController.changeObscure(),
                              child: Icon(authController.isObscureText.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                            ),
                            hint: 'Password', controller: authController.passwordController);
                      }
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                        onValidator: ValidationService.validateConfirmPassword,
                        obscureText: authController.isObscureText.value,
                        prefix: const Icon(Icons.lock_outline_rounded),
                        hint: 'Confirm Password', controller: authController.confirmPasswordController),
                    const SizedBox(height: 20),
                    Row(children: [
                      CustomCheckBox(
                        value: authController.agreeTerms.value,
                        onChanged: (v) => authController.changeAgreeTerm(v),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            text: 'I agree to the ',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                            children: [
                              TextSpan(text: 'Terms of Service', style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.w600)),
                              TextSpan(text: ' and '),
                              TextSpan(text: 'Privacy Policy', style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 28),
                    GradientButton(label: authController.isLoading.value ? 'Creating account...' : 'Create Account',
                        onTap: authController.isLoading.value ? () {} : (){
                          if(_validation.currentState?.validate()??false){
                            authController.signupUser(context);
                          }

                        }),
                    const SizedBox(height: 24),
                    Center(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                            children: [TextSpan(text: 'Sign In', style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.w700))],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

}


// lib/views/auth/forgot_password_screen.dart (in same file for brevity, split manually)
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _sent = false;
  bool _loading = false;

  void _send() {
    setState(() => _loading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() { _loading = false; _sent = true; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _sent ? _successView(context) : _formView(context),
        ),
      ),
    );
  }

  Widget _formView(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(color: AppColors.blue.withOpacity(0.2), shape: BoxShape.circle),
        child: const Center(child: Text('🔑', style: TextStyle(fontSize: 36))),
      ),
      const SizedBox(height: 24),
      Text('Forgot Password?', style: Theme.of(context).textTheme.headlineLarge),
      const SizedBox(height: 8),
      Text("No worries! Enter your email and we'll send you a reset link.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
      const SizedBox(height: 36),
      TextFormField(
        initialValue: 'hello@family.com',
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.mail_outline_rounded)),
      ),
      const SizedBox(height: 28),
      GradientButton(label: _loading ? 'Sending...' : 'Send Reset Link', onTap: _loading ? () {} : _send, icon: Icons.send_rounded),
    ],
  );

  Widget _successView(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(color: AppColors.green, shape: BoxShape.circle),
          child: const Center(child: Text('✉️', style: TextStyle(fontSize: 60))),
        ),
        const SizedBox(height: 28),
        Text('Check your email!', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        Text('We\'ve sent a password reset link to\nhello@family.com', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
        const SizedBox(height: 36),
        AppButton(label: 'Back to Login', onTap: () => Get.back()),
        const SizedBox(height: 16),
        TextButton(
          onPressed: _send,
          child: const Text("Didn't receive? Resend", style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}
