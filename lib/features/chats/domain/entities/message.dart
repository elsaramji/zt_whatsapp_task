abstract class Message {
  String chatId;
  String senderId;
  String? content;
  String timeSendIn;

  Message({
    required this.chatId,
    required this.senderId,    
    required this.timeSendIn,
    this.content,
  });
}
