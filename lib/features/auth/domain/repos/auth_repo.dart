import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class AuthRepo {
  Future<Either<Exception, User>> loginuser(String phoneNumber);
  
}
