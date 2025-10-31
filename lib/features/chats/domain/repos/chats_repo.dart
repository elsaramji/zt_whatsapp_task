import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';

import '../../../auth/domain/entities/user.dart';
import '../entities/chat.dart';

abstract class ChatsRepo {
  Future<void> sendMessage(String chatId, MessageModel message);
  Future<void> createChat(
    List<String> participants,
   List<MessageModel> messages,
  );
  Future<Either<Exception, Chat>> getChat(String chatId);
}
