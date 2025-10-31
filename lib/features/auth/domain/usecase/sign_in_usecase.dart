import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:zt_whatsapp_task/features/auth/data/models/user_model.dart';

import '../entities/user.dart';
import '../repos/auth_repo.dart';

class SignInUseCase {
  final AuthRepo authRepo;
  SignInUseCase(this.authRepo);
  Future<Either<Exception, User>> call(String phoneNumber)async {
    return await authRepo.loginuser(phoneNumber);
  }
  Future<void> saveUserId(UserModel user) async {
    await authRepo.saveUserLocally(user);
  }
}
