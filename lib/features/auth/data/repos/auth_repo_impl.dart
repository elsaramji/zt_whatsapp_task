import 'package:zt_whatsapp_task/features/auth/domain/entities/user.dart';

import '../../domain/repos/auth_repo.dart';
import '../source/firebase_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseDataSource firebaseDataSource;

  AuthRepoImpl(this.firebaseDataSource);

  @override
  Future<void> signIn(String phoneNumber) {
    return firebaseDataSource.signIn(phoneNumber);
  }
}
