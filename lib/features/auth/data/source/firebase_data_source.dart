import 'package:firebase_auth/firebase_auth.dart';
import 'package:zt_whatsapp_task/features/auth/data/models/user_model.dart';

abstract class FirebaseDataSource {
  Future<void> signIn(String phoneNumber);
}

class FirebaseDataSourceImpl implements FirebaseDataSource {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> signIn(String phoneNumber) async {
    // Call Firebase Auth to sign in the user
    await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
  }
}