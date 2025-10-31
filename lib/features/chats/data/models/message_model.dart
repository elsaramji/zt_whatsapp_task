import '../../domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.chatId,
    required super.senderId,
    required super.timeSendIn,
    super.content, 
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    chatId: json['chatId'],
    senderId: json['senderId'],
    timeSendIn: json['timeSendIn'],
    content: json['content'],
  );
  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'senderId': senderId,
    'timeSendIn': timeSendIn,
    'content': content,
  };
}
