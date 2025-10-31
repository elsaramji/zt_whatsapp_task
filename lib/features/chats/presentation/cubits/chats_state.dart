import 'package:equatable/equatable.dart';
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

// عند العثور على محادثة سابقة أو إنشاء واحدة جديدة
class ChatsLoaded extends ChatsState {
  final Chat chats;
  const ChatsLoaded(this.chats);
  @override
  List<Object> get props => [chats];
}

// في حال لم يتم العثور على محادثة (شاشة فارغة)
class ChatEmpty extends ChatsState {}

// في حال حدوث خطأ
class ChatsFailure extends ChatsState {
  final String message;
  const ChatsFailure(this.message);
  @override
  List<Object> get props => [message];
}
