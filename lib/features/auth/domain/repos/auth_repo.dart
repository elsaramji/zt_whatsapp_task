

abstract class AuthRepo {
  Future<void> signIn(String phoneNumber);
 /* Future<User> getCurrentUser(
    String userId,
    String phoneNumber,
    String name,
    String avatar,
  );
  Future<void> verifyOtp(String verificationId, String otp);*/
}
