abstract class Message {
  String chatId;
  String senderId;
  String? content;
  DateTime timeSendIn;

  Message({
    required this.chatId,
    required this.senderId,    
    required this.timeSendIn,
    this.content,
  });
}
