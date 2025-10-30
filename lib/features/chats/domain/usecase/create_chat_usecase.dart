import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';
import 'package:zt_whatsapp_task/features/chats/domain/repos/chats_repo.dart';

class CreateChatUseCase {
  final ChatsRepo chatsRepo;
  CreateChatUseCase(this.chatsRepo);
  Future<void> call(List<String> participants, MessageModel message) async {
    await chatsRepo.createChat(participants, message);
  }
}
