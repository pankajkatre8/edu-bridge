class AuthService {
  static Future<void> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // No actual authentication - just mock success
    return;
  }
}