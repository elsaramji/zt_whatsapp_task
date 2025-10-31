import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zt_whatsapp_task/features/auth/data/models/user_model.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';
import 'package:zt_whatsapp_task/features/chats/presentation/cubits/chat_cubit.dart';

// --- بيانات وهمية لتعمل الواجهة ---

// لنفترض أن هذا هو ID المستخدم الحالي
const String CURRENT_USER_ID = "user_123";

// فئة رسالة وهمية (مبسطة)
class FakeMessage extends MessageModel {
  FakeMessage({
    required super.chatId,
    required super.senderId,
    required super.timeSendIn,

    required super.content,
  });
}

// ألوان وهمية (مأخوذة من الثيم الخاص بك)
class AppColors {
  static const Color primary = Color(0xFF00A884);
  static const Color grey = Color(0xFF8696A0);
}

// --- نهاية البيانات الوهمية ---

class ChatDetailView extends StatelessWidget {
  // لم نعد بحاجة لـ chatId هنا، لكن سنتركه
  final String chatId;
  final UserModel user;
  final String receiverId;
  const ChatDetailView({
    super.key,
    required this.chatId,
    required this.receiverId,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // هذه الواجهة الآن لا تعتمد على Cubit
    return _ChatDetailViewBody(receiverId: receiverId, user: user);
  }
}

class _ChatDetailViewBody extends StatefulWidget {
  final String receiverId;
  final UserModel user;

  const _ChatDetailViewBody({required this.receiverId, required this.user});

  @override
  State<_ChatDetailViewBody> createState() => _ChatDetailViewBodyState();
}

class _ChatDetailViewBodyState extends State<_ChatDetailViewBody> {
  final TextEditingController _messageController = TextEditingController();

  // قائمة رسائل وهمية محلية
  final List<FakeMessage> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // دالة إرسال وهمية
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = FakeMessage(
      chatId: "$CURRENT_USER_ID${widget.receiverId}",
      senderId: CURRENT_USER_ID,
      timeSendIn: DateTime.now(),

      content: _messageController.text,
    );

    setState(() {
      _messages.add(newMessage);
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => ChatsCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: colors.surface.withAlpha(1000),
            appBar: AppBar(
              leadingWidth: 30.w,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.user.avatar ??
                          'https://www.gravatar.com/avatar/placeholder',
                    ),
                    radius: 16.r,
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.fade,
                        widget.user.name ?? 'Unknown', // مطابق للصورة

                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        widget.user.phone, // مطابق للصورة
                        style: textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            ),
            // يمكنك إضافة صورة الخلفية هنا
            // body: Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: NetworkImage("https://.../whatsapp_background.png"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   child: Column(...)
            // ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // reverse: true, // لن نستخدم reverse هنا لأننا نريد التمرير للأسفل
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final bool isMe = message.senderId == CURRENT_USER_ID;

                      // في لقطة الشاشة، حتى رسائلك تظهر على اليسار
                      // لكن سلوك واتساب الطبيعي هو أن رسائلك على اليمين
                      // سنلتزم بالسلوك الطبيعي (isMe = true -> right side)

                      // إذا أردت الالتزام بالصورة 100% (كل الرسائل يسار):
                      // final bool isMeForUI = false;

                      // السلوك الطبيعي:
                      final bool isMeForUI = isMe;

                      return _ChatBubble(message: message, isMe: isMeForUI);
                    },
                  ),
                ),
                _MessageInputBar(
                  controller: _messageController,
                  onSend: () {
                    _sendMessage();
                    context.read<ChatsCubit>().createChat(
                      CURRENT_USER_ID,
                      widget.receiverId, // ID المستلم الوهمي
                      _messages,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- ويدجت فقاعة الرسالة ---
class _ChatBubble extends StatelessWidget {
  final FakeMessage message;
  final bool isMe;

  const _ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // هذه الألوان مطابقة للصورة (أخضر فاتح وأبيض/رمادي داكن)
    final bubbleColor = isMe
        ? const Color(0xFFE7FFDB)
        : (Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF1F2C34));
    final textColor = isMe ? Colors.black : colors.onSurface;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        constraints: BoxConstraints(maxWidth: 0.75.sw), // تحديد عرض أقصى
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.end, // الوقت دائمًا في الأسفل يمين
          children: [
            Text(
              message.content ?? "",
              style: textTheme.bodyMedium?.copyWith(color: textColor),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  // تنسيق الوقت
                  "${message.timeSendIn.hour}:${message.timeSendIn.minute.toString().padLeft(2, '0')}",
                  style: textTheme.labelMedium?.copyWith(
                    color: isMe ? AppColors.grey : AppColors.grey,
                  ),
                ),
                if (isMe) SizedBox(width: 4.w),
                if (isMe) // إظهار علامة الصحين فقط لرسائلي
                  Icon(
                    Icons.done_all,
                    color: Colors.blue.shade400,
                    size: 16.sp,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- ويدجت شريط الإدخال ---
class _MessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _MessageInputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h).copyWith(
        bottom:
            MediaQuery.of(context).padding.bottom + 8.h, // لتجنب تداخل الكيبورد
      ),
      color: colors.surface,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade100
                    : const Color(0xFF1F2C34)),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: AppColors.grey,
                      size: 24.sp,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLines: 5,
                      minLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.attach_file,
                      color: AppColors.grey,
                      size: 24.sp,
                    ),
                  ),
                  // إخفاء الكاميرا إذا كان هناك نص
                  if (controller.text.isEmpty)
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.grey,
                        size: 24.sp,
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.primary,
            child: IconButton(
              onPressed: onSend,
              // تغيير الأيقونة بناءً على النص
              icon: Icon(Icons.send, color: Colors.white, size: 24.sp),
            ),
          ),
        ],
      ),
    );
  }
}
