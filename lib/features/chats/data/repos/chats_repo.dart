import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/chat_model.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';
import 'package:zt_whatsapp_task/features/chats/data/source/chat_data_source.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/repos/chats_repo.dart';

class ChatsRepoFireStoreImpl implements ChatsRepo {
  final ChatDataSource dataSource;

  ChatsRepoFireStoreImpl(this.dataSource);

  @override
  Future<void> createChat(
    List<String> participants,
    List<MessageModel> messages,
  ) async {
    await dataSource.createChat(participants, messages);
  }


  @override
  Future<void> sendMessage(String chatId, MessageModel message) async {
    await dataSource.sendMessage(chatId, message);
  }
  @override
  Future<Either<Exception, ChatModel>> getChat(String chatId) async {
    return await dataSource.getChat(chatId);
  }
}
