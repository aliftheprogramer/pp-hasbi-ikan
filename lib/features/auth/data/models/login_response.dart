import '../../domain/entity/login_response_entity.dart';
import 'user_model.dart';

class LoginResponse extends LoginResponseEntity {
  const LoginResponse({super.success, super.user, super.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      user: json['data'] != null && json['data']['user'] != null
          ? UserModel.fromJson(json['data']['user'])
          : null,
      token: json['data'] != null ? json['data']['token'] : null,
    );
  }
}
