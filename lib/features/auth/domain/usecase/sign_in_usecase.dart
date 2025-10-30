
import '../repos/auth_repo.dart';

class SignInUseCase {
  final AuthRepo authRepo;

  SignInUseCase(this.authRepo);

  Future<void> call(String phoneNumber) {
    return authRepo.signIn(phoneNumber);
  }
}