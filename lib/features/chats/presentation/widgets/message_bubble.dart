import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final DateTime time;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    // 1. Determine bubble color based on mode (dark/light) and sender
    final bubbleColor = isMe
        ? (isLightMode ? AppColors.lightGreen : AppColors.darkGreen)
        : colors.surface;
    
    // 2. تحديد لون النص
    final textColor = isMe ? Colors.black : colors.onSurface;

    // 3. Align bubble right or left
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        constraints: BoxConstraints(maxWidth: 0.75.sw), // Maximum width for bubble
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            if (!isMe) // Add light shadow for received messages
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(1, 1),
              ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Make column wrap content
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // 4. Message text
            Text(
              message,
              style: TextStyle(color: textColor, fontSize: 16.sp),
            ),
            SizedBox(height: 4.h),
            // 5. Time and read marks
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('h:mm a').format(time), // تنسيق الوقت
                  style: TextStyle(
                    color: isMe ? AppColors.grey : colors.onSurfaceVariant,
                    fontSize: 12.sp,
                  ),
                ),
                if (isMe) ...[
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.done_all,
                    color: AppColors.blueLink, // Color for read marks
                    size: 16.sp,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
