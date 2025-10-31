import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zt_whatsapp_task/core/routes/app_routes.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Chats View (Placeholder)',
          style: TextStyle(color: Colors.black),
        ),
      ),
      // 1. الزر العائم (FAB) يظهر فقط في شاشة "Chats"
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement new chat action
          context.push(AppRoutes.getContacts);
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
