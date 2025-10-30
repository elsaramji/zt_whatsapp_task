import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../repos/auth_repo.dart';

class SignInUseCase {
  final AuthRepo authRepo;

  SignInUseCase(this.authRepo);

  Future<Either<Exception, User>> call(String phoneNumber) {
    return authRepo.loginuser(phoneNumber);
  }
}
