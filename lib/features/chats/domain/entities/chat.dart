import 'message.dart';

abstract class Chat {
  String id;
  List<String> participants;
  List<Message> messages;

  Chat({required this.id, required this.participants, required this.messages});
}
