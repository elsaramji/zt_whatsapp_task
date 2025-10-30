import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';

import '../repos/chats_repo.dart';

class SendMessageUseCase {
  final ChatsRepo chatsRepo;
  SendMessageUseCase(this.chatsRepo);
  Future<void> call(String chatId, String messageContent, String senderId) async {
    // Here you would typically create a MessageModel instance
    // For simplicity, let's assume MessageModel has a constructor that takes content
    final message = MessageModel(
      chatId: chatId,
      senderId: senderId,
      timeSendIn: DateTime.now(),
      content: messageContent,
    );
    await chatsRepo.sendMessage(chatId, message);
  }
}
