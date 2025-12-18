import 'package:pui_bhasbi_mobile/features/auth/domain/entity/user_entity.dart';

abstract class AuthState {}

class AppInitialState extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;
  Authenticated(this.user);
}

class UnAuthenticated extends AuthState {}

class FirstRun extends AuthState {}
