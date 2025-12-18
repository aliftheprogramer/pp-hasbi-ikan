import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> saveUserId(String id);
  Future<String?> getUserId();
}

class AuthLocalServiceImpl implements AuthLocalService {
  final SharedPreferences _sharedPreferences;

  AuthLocalServiceImpl(this._sharedPreferences);

  @override
  Future<void> saveToken(String token) async {
    await _sharedPreferences.setString('auth_token', token);
  }

  @override
  Future<String?> getToken() async {
    return _sharedPreferences.getString('auth_token');
  }

  @override
  Future<void> clearToken() async {
    await _sharedPreferences.remove('auth_token');
  }

  @override
  Future<void> saveUserId(String id) async {
    await _sharedPreferences.setString('user_id', id);
  }

  @override
  Future<String?> getUserId() async {
    return _sharedPreferences.getString('user_id');
  }
}
