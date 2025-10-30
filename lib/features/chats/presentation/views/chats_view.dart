import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Chats View (Placeholder)',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      // 1. الزر العائم (FAB) يظهر فقط في شاشة "Chats"
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement new chat action
        },
        label: Text(
          'Send message',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        icon: Icon(Icons.chat_bubble_outline, size: 24.sp),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
