import 'package:zt_whatsapp_task/features/auth/domain/entities/user.dart';

import 'message.dart';

abstract class Chat {
  String id;
  List<String> participants;
  List<Message> messages;

  Chat({
    required this.id,
    required this.participants,
    required this.messages,
  });
}
