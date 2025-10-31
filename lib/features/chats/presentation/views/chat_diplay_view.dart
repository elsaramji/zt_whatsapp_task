import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/chat_model.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';
import 'package:zt_whatsapp_task/features/chats/presentation/cubits/chat_cubit.dart';

// --- Dummy data for the interface to work ---

// Let's assume this is the current user ID
const String CURRENT_USER_ID = "user_123";

// Simplified fake message class
class FakeMessage extends MessageModel {
  FakeMessage({
    required super.chatId,
    required super.senderId,
    required super.timeSendIn,

    required super.content,
  });
}

// Dummy colors (taken from your theme)
class AppColors {
  static const Color primary = Color(0xFF00A884);
  static const Color grey = Color(0xFF8696A0);
}

// --- End of dummy data ---

class ChatDispalyView extends StatelessWidget {
  // We no longer need chatId here, but we'll keep it
  final ChatModel chat;

  const ChatDispalyView({super.key, required this.chat});
  @override
  Widget build(BuildContext context) {
    // This interface no longer depends on Cubit
    return _ChatDisPlayViewBody(chat: chat);
  }
}

class _ChatDisPlayViewBody extends StatefulWidget {
  final ChatModel chat;

  const _ChatDisPlayViewBody({required this.chat});

  @override
  State<_ChatDisPlayViewBody> createState() => _ChatDisPlayViewBodyState();
}

class _ChatDisPlayViewBodyState extends State<_ChatDisPlayViewBody> {
  final TextEditingController _messageController = TextEditingController();

  // Dummy message list for testing

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // Dummy send function
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = FakeMessage(
      chatId: "$CURRENT_USER_ID${widget.chat.participants[1]}",
      senderId: CURRENT_USER_ID,
      timeSendIn:
          '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',

      content: _messageController.text,
    );

    setState(() {
      widget.chat.messages.add(newMessage);
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
                      'https://www.gravatar.com/avatar/placeholder',
                    ),
                    radius: 16.r,
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.visible,
                        "JoneDue", // Matches the image

                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        overflow: TextOverflow.visible,
                        "Online", // Matches the image
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
            // You can add background image here
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
                    // reverse: true, // We won't use reverse here because we want to scroll down
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    itemCount: widget.chat.messages.length,
                    itemBuilder: (context, index) {
                      final message = widget.chat.messages[index];
                      final bool isMe = message.senderId == CURRENT_USER_ID;

                      // In the screenshot, even your messages appear on the left
                      // But WhatsApp's natural behavior is that your messages are on the right
                      // We'll stick with the natural behavior (isMe = true -> right side)

                      // If you want to stick to the image 100% (all messages on the left):
                      // final bool isMeForUI = false;

                      // Natural behavior:
                      final bool isMeForUI = isMe;

                      return _ChatBubble(
                        message: message.content ?? "",
                        isMe: isMeForUI,
                      );
                    },
                  ),
                ),
                _MessageInputBar(
                  controller: _messageController,
                  onSend: () {
                    _sendMessage();
                    context.read<ChatsCubit>().createChat(
                      CURRENT_USER_ID,
                      widget.chat.participants[1],
                      widget.chat.messages as List<MessageModel>,
                      // ID المستلم الوهمي
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
  final String message;
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
        constraints: BoxConstraints(maxWidth: 0.75.sw), // Set maximum width
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
              CrossAxisAlignment.end, // Time always at the bottom right
          children: [
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(color: textColor),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  // Time formatting
                  '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                  style: textTheme.labelMedium?.copyWith(
                    color: isMe ? AppColors.grey : AppColors.grey,
                  ),
                ),
                if (isMe) SizedBox(width: 4.w),
                if (isMe) // Show double check marks only for my messages
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
            MediaQuery.of(context).padding.bottom + 8.h, // To avoid keyboard overlap
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
                  // Hide camera if there is text
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
              // Change icon based on text
              icon: Icon(Icons.send, color: Colors.white, size: 24.sp),
            ),
          ),
        ],
      ),
    );
  }
}
