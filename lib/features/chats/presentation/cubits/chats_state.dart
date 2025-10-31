import 'package:equatable/equatable.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/chat_model.dart';
import 'package:zt_whatsapp_task/features/chats/domain/entities/chat.dart';
import 'package:zt_whatsapp_task/features/chats/domain/entities/message.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();
  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsSuccess extends ChatsState {}

class ChatsError extends ChatsState {
  final String message;
  const ChatsError(this.message);
  @override
  List<Object> get props => [message];
}

// When finding a previous conversation or creating a new one
class ChatsLoaded extends ChatsState {
  final List<ChatModel> chats;
  const ChatsLoaded(this.chats);
  @override
  List<Object> get props => [chats];
}

// When no conversation is found (empty screen)
class ChatEmpty extends ChatsState {}

// In case of an error
class ChatsFailure extends ChatsState {
  final String message;
  const ChatsFailure(this.message);
  @override
  List<Object> get props => [message];
}
