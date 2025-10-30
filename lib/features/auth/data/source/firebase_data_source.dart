import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zt_whatsapp_task/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<Either<Exception, UserModel>> loginUser(String phoneNumber);
}

class FirebaseDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');
  @override
  Future<Either<Exception, UserModel>> loginUser(String phoneNumber) async {
    // Call Firebase Auth to sign in the user
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: "mm$phoneNumber@example.com",
            password: phoneNumber,
          );
      UserModel userData = UserModel(
        id: userCredential.user!.uid,
        phone: phoneNumber,
      );
      _usersCollection.doc(userData.phone).set(userData.toJson());
      return right(userData);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(
              email: "mm$phoneNumber@example.com",
              password: phoneNumber,
            );
        return right(
          UserModel(id: userCredential.user!.uid, phone: phoneNumber),
        );
      } else {
        return left(Exception("error in login"));
      }
    } catch (e) {
      return left(Exception("un expected error"));
    }
  }
}
