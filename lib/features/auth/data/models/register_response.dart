import '../../domain/entity/register_response_entity.dart';
import 'user_model.dart';

class RegisterResponse extends RegisterResponseEntity {
  const RegisterResponse({super.success, super.user, super.token});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'],
      user: json['data'] != null && json['data']['user'] != null
          ? UserModel.fromJson(json['data']['user'])
          : null,
      token: json['data'] != null ? json['data']['token'] : null,
    );
  }
}
