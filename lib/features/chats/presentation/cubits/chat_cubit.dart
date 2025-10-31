import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';
import 'package:zt_whatsapp_task/features/chats/data/repos/chats_repo.dart';
import 'package:zt_whatsapp_task/features/chats/data/source/chat_data_source.dart';
import 'package:zt_whatsapp_task/features/chats/domain/usecase/create_chat_usecase.dart';

import '../../domain/entities/chat.dart';
import '../../domain/usecase/get_chats_usecase.dart';
import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final CreateChatUseCase createChatUseCase = CreateChatUseCase(
    ChatsRepoFireStoreImpl(ChatDataSourceImpl()),
  );

  final GetChatUseCase getChatUseCase = GetChatUseCase(
    ChatsRepoFireStoreImpl(ChatDataSourceImpl()),
  );
  ChatsCubit() : super(ChatsInitial());

  Future<void> createChat(
    String senderId,
    String receiverId,
    List<MessageModel> massages,
  ) async {
    emit(ChatsLoading());
    await createChatUseCase.call([senderId, receiverId], massages);
    emit(ChatsSuccess());
  }

  Future<Either<Exception, Chat>> getChat(String chatId) async {
    emit(ChatsLoading());

    final result = await getChatUseCase.call(chatId);
    result.fold(
      (failure) => emit(ChatsError(failure.toString())),
      (chat) => emit(ChatsLoaded(chat)),
    );
    return result;
  }
}
