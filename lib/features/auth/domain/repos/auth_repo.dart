import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/auth/data/models/user_model.dart';

import '../entities/user.dart';

abstract class AuthRepo {
  Future<Either<Exception, User>> loginuser(String phoneNumber);
  Future<Either<Exception, UserModel>> getUser(String userId);
  Future<void> saveUserLocally(UserModel user);
  Future<String?> getUserLocally();
}
