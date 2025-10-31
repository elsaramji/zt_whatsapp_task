import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/chat_model.dart';
import 'package:zt_whatsapp_task/features/chats/data/models/message_model.dart';

abstract class ChatDataSource {
  Future<void> sendMessage(String chatId, MessageModel message);
  Future<void> createChat(List<String> participants, List<MessageModel> messages);
  Future<Either<Exception, ChatModel>> getChat(String chatId);
}

class ChatDataSourceImpl implements ChatDataSource {
  final CollectionReference _collectionReference = FirebaseFirestore.instance
      .collection('chats');
  @override
  Future<void> sendMessage(String chatId, MessageModel message) async {
    final chatDoc = _collectionReference.doc(chatId);
    final chatSnapshot = await chatDoc.get();
    if (chatSnapshot.exists) {
      final messages = List<Map<String, dynamic>>.from(
        chatSnapshot.get('messages') as List,
      );
      messages.add(message.toJson());
      await chatDoc.update({'messages': messages});
    } else {
      throw Exception('Chat with id $chatId does not exist');
    }
  }

  @override
  Future<void> createChat(
    List<String> participants,
    List<MessageModel> messages,
  ) async {
    final chatDoc = _collectionReference.doc(
      "${participants[0]}_${participants[1]}",
    );
    await chatDoc.set({
      'id': chatDoc.id,
      'participants': participants,
      'messages': messages.map((msg) => msg.toJson()).toList(),
    });
  }

  @override
  Future<Either<Exception, ChatModel>> getChat(String chatId) async {
    final chatDoc = _collectionReference.doc(chatId);
    final chatSnapshot = await chatDoc.get();
    if (chatSnapshot.exists) {
      return right(
        ChatModel.fromJson(chatSnapshot.data()! as Map<String, dynamic>),
      );
    } else {
      return left(Exception('Chat with id $chatId does not exist'));
    }
  }
}
