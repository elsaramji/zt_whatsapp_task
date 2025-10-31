import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/chat_model.dart';
import 'package:zt_whatsapp_task/features/chats/domain/repos/chats_repo.dart';

import '../entities/chat.dart';

class GetChatUseCase {
  final ChatsRepo chatsRepo;

  GetChatUseCase(this.chatsRepo);

  Future<Either<Exception, List<ChatModel>>> call() {
    return chatsRepo.getChats();
  }
}