import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/auth/domain/entities/user.dart';

import '../../domain/repos/auth_repo.dart';
import '../source/firebase_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource firebaseDataSource;

  AuthRepoImpl(this.firebaseDataSource);

  @override
  Future<Either<Exception, User>> loginuser(String phoneNumber) {
    return firebaseDataSource.loginUser(phoneNumber);
  }
}
