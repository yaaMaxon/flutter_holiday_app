abstract class UserRepository {
  Future<void> saveUser(String email, String password, String name);
  Future<Map<String, String>?> getUser();
  Future<void> logout();
  Future<void> clearUser();
  Future<bool> isLoggedIn();
}
