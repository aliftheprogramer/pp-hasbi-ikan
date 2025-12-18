import '../../domain/entity/login_request_entity.dart';

class LoginRequest extends LoginRequestEntity {
  const LoginRequest({required super.email, required super.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
