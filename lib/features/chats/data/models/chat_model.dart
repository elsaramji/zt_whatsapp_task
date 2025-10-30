import '../../domain/entities/chat.dart';
import 'message_model.dart';

class ChatModel extends Chat {
  ChatModel({
    required super.id,
    required super.participants,
    required super.messages,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String,
      participants: List<String>.from(json['participants'] as List),
      messages: (json['messages'] as List)
          .map((msg) => MessageModel.fromJson(msg as Map<String, dynamic>))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'messages': messages
          .map((msg) => (msg as MessageModel).toJson())
          .toList(),
    };
  }
}
