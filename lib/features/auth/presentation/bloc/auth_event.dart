import 'package:equatable/equatable.dart';
import '../../domain/entity/login_request_entity.dart';
import '../../domain/entity/register_request_entity.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginRequestEntity params;

  const LoginEvent(this.params);

  @override
  List<Object> get props => [params];
}

class RegisterEvent extends AuthEvent {
  final RegisterRequestEntity params;

  const RegisterEvent(this.params);

  @override
  List<Object> get props => [params];
}
