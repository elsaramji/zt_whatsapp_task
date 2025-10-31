import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';

class ChatInputBar extends StatefulWidget {
  final Function(String) onSend;

  const ChatInputBar({super.key, required this.onSend});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showSendButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showSendButton = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_showSendButton) {
      widget.onSend(_controller.text.trim());
      _controller.clear();
    } else {
      // TODO: Implement voice message logic
      print('Start recording voice message');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      color: colors.surface, // لون الخلفية لشريط الإدخال
      child: Row(
        children: [
          // 1. حقل إدخال النص
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colors.background, // لون الخلفية لحقل النص
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: Implement emoji picker
                    },
                    icon: Icon(Icons.emoji_emotions_outlined,
                        color: colors.onSurfaceVariant),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: null, // للسماح بتعدد الأسطر
                      decoration: InputDecoration(
                        hintText: 'Message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintStyle: TextStyle(color: colors.onSurfaceVariant),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement attach file
                    },
                    icon: Icon(Icons.attach_file,
                        color: colors.onSurfaceVariant),
                  ),
                  // 2. إظهار الكاميرا فقط إذا كان الحقل فارغاً
                  if (!_showSendButton)
                    IconButton(
                      onPressed: () {
                        // TODO: Implement camera
                      },
                      icon: Icon(Icons.camera_alt_outlined,
                          color: colors.onSurfaceVariant),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // 3. زر الإرسال أو الميكروفون
          FloatingActionButton(
            onPressed: _handleSend,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            child: Icon(
              _showSendButton ? Icons.send : Icons.mic,
            ),
          ),
        ],
      ),
    );
  }
}
