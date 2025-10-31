
import '../repos/auth_repo.dart';

class GetUserIDUseCase {
  final AuthRepo authRepo;
  GetUserIDUseCase(this.authRepo);
  Future<String?> call()async {
    return await authRepo.getUserLocally();
  }
}
