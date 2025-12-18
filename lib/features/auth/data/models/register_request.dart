import '../../domain/entity/register_request_entity.dart';

class RegisterRequest extends RegisterRequestEntity {
  const RegisterRequest({
    required super.email,
    required super.password,
    required super.name,
    super.role,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'name': name, 'role': role};
  }
}
