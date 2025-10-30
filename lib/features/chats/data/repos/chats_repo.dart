import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';
import 'package:zt_whatsapp_task/features/chats/data/source/chat_data_source.dart';

import '../../domain/repos/chats_repo.dart';

class ChatsRepoFireStoreImpl implements ChatsRepo {
  final ChatDataSource dataSource;

  ChatsRepoFireStoreImpl(this.dataSource);

  @override
  Future<void> createChat(
    List<String> participants,
    MessageModel message,
  ) async {
    await dataSource.createChat(participants, message);
  }

  @override
  Future<void> sendMessage(String chatId, MessageModel message) async {
    await dataSource.sendMessage(chatId, message);
  }
}
