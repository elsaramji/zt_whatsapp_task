import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/auth/data/models/user_model.dart';

import '../../../auth/domain/entities/user.dart';

abstract class GetContactSource {
  Future<Either<Exception, List<User>>> getContact();
}

class GetContactSourceImpl implements GetContactSource {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  @override
  Future<Either<Exception, List<UserModel>>> getContact() async {
    try {
      QuerySnapshot querySnapshot = await usersCollection.get();
      List<UserModel> users = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson(data);
      }).toList();
      return Right(users);
    } catch (e) {
      return Left(Exception('Failed to fetch contacts: $e'));
    }
  }
}
