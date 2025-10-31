import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zt_whatsapp_task/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<Either<Exception, UserModel>> loginUser(String phoneNumber);
  Future<Either<Exception, UserModel>> getUser(String userId);
  Future<void> saveUserLocally(UserModel user);
  Future<String?> getUserLocally();
}

class AuthDataSourceImpl implements AuthDataSource {
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
        name: "demo$phoneNumber",
        avatar: "https://placehold.co/100x100/grey/white?text=User",
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

  @override
  Future<Either<Exception, UserModel>> getUser(String userId) async {
    try {
      DocumentSnapshot snapshot = await _usersCollection.doc(userId).get();
      return right(UserModel.fromJson(snapshot.data() as Map<String, dynamic>));
    } catch (e) {
      return left(Exception("un expected error"));
    }
  }

  // save user locally as shared preferences
  @override
  Future<void> saveUserLocally(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', user.id);
    log("User saved locally: ${user.id}");
  }

  // get user locally from shared preferences
  @override
  Future<String?> getUserLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userid');
    if (userId != null) {
      log("User retrieved locally: $userId");
      return userId;
    }
    return null;
  }
}
