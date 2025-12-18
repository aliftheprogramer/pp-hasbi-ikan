import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pui_bhasbi_mobile/features/auth/data/models/user_model.dart';

abstract class AuthLocalService {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> saveUserId(String id);
  Future<String?> getUserId();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
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
    await _sharedPreferences.remove('user_data');
  }

  @override
  Future<void> saveUserId(String id) async {
    await _sharedPreferences.setString('user_id', id);
  }

  @override
  Future<String?> getUserId() async {
    return _sharedPreferences.getString('user_id');
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final String userJson = jsonEncode(user.toJson());
    await _sharedPreferences.setString('user_data', userJson);
  }

  @override
  Future<UserModel?> getUser() async {
    final String? userJson = _sharedPreferences.getString('user_data');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
