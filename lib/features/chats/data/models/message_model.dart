import '../../domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.chatId,
    required super.senderId,
    required super.timeSendIn,
    super.content,
    super.fileUrl,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    chatId: json['chatId'],
    senderId: json['senderId'],
    timeSendIn: json['timeSendIn'],
    content: json['content'],
    fileUrl: json['fileUrl'],
  );
  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'senderId': senderId,
    'timeSendIn': timeSendIn.toIso8601String(),
    'content': content,
    'fileUrl': fileUrl,
  };
}
