import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class LoginResponseEntity extends Equatable {
  final bool? success;
  final UserEntity? user;
  final String? token;

  const LoginResponseEntity({this.success, this.user, this.token});

  @override
  List<Object?> get props => [success, user, token];
}
