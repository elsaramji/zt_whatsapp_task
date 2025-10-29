abstract class Message {
  String id;
  String chatId;
  String senderId;
  String? content;
  String? fileUrl;
  DateTime timeSendIn;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.timeSendIn,
    this.content,
    this.fileUrl,
  });
}
