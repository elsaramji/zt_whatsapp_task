import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zt_whatsapp_task/core/routes/app_routes.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.accessibility_new,
                    size: 24.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),

              const Spacer(),

              Image.asset('assets/images/welcome_image.png', height: 250.h),

              const Spacer(),

              Text(
                'Welcome to WhatsApp',
                style: textTheme.titleLarge?.copyWith(color: colors.onSurface),
              ),

              SizedBox(height: 20.h),

              RichText(
                text: TextSpan(
                  text: 'Read our ',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                  ),
                  children: [
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(color: AppColors.blueLink),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(
                      text: '. Tap "Agree and continue" to accept the ',
                    ),
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(color: AppColors.blueLink),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 30.h),

              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.language, color: AppColors.primary, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'English',
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to phone number input screen
                    context.go(AppRoutes.login);
                  },
                  child: const Text('Agree and continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
