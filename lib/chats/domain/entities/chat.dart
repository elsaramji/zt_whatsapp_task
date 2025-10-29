import 'massage.dart';

abstract class Chat {
  String id;
  String senderId;
  String recipientId;
  List<Message> messages;

  Chat({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.messages,
  });
}