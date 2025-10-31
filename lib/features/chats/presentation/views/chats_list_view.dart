import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zt_whatsapp_task/core/routes/app_routes.dart';
import 'package:zt_whatsapp_task/core/theme/app_colors.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/chat_model.dart';
import 'package:zt_whatsapp_task/features/chats/presentation/cubits/chat_cubit.dart';

import '../cubits/chats_state.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit(),

      child: Builder(
        builder: (context) {
          context.read<ChatsCubit>().getChat();
          return BlocBuilder<ChatsCubit, ChatsState>(
            builder: (context, state) {
              if (state is ChatsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ChatsError) {
                return Center(child: Text(state.message));
              } else if (state is ChatsLoaded) {
                return Scaffold(
                  appBar: AppBar(title: Text('Chats')),
                  body: ListView.builder(
                    itemCount: state.chats.length,
                    itemBuilder: (context, index) =>
                        ChatListTile(chat: state.chats[index]),
                  ),
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
              } else {
                return Center(child: Text('No chats available.'));
                // 1. The floating action button (FAB) appears only in the "Chats" screen
              }
            },
          );
        },
      ),
    );
  }
}

class ChatListTile extends StatelessWidget {
  final ChatModel chat;
  const ChatListTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(AppRoutes.displayChat, extra: chat);
      },
      leading: CircleAvatar(
        backgroundColor: AppColors.primary,
        child: Icon(Icons.person, size: 24.sp),
      ),
      title: Text('Chat with Jone Due'),
      subtitle: Text(
        'Last message: ${chat.messages.isNotEmpty ? chat.messages.last.content : 'No messages yet.'}',
      ),
    );
  }
}
