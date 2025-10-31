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

    // 1. تحديد لون الفقاعة بناءً على الوضع (مظلم/مضيء) والمرسل
    final bubbleColor = isMe
        ? (isLightMode ? AppColors.lightGreen : AppColors.darkGreen)
        : colors.surface;
    
    // 2. تحديد لون النص
    final textColor = isMe ? Colors.black : colors.onSurface;

    return Align(
      // 3. محاذاة الفقاعة يميناً أو يساراً
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        constraints: BoxConstraints(maxWidth: 0.75.sw), // أقصى عرض للفقاعة
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomLeft: isMe ? Radius.circular(12.r) : Radius.circular(0.r),
            bottomRight: isMe ? Radius.circular(0.r) : Radius.circular(12.r),
          ),
          boxShadow: [
            if (!isMe) // إضافة ظل خفيف للرسائل المستلمة
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(1, 1),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min, // لجعل العمود يحتضن المحتوى
          children: [
            // 4. نص الرسالة
            Text(
              message,
              style: TextStyle(color: textColor, fontSize: 16.sp),
            ),
            SizedBox(height: 4.h),
            // 5. الوقت وعلامات القراءة
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
                    color: AppColors.blueLink, // لون علامات القراءة
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
