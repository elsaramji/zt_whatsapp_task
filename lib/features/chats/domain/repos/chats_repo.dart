

import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';


abstract class ChatsRepo {
  Future<void> sendMessage(String chatId, MessageModel message);
  Future<void> createChat(List<String> participants, MessageModel message);
}
