import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class RegisterResponseEntity extends Equatable {
  final bool? success;
  final UserEntity? user;
  final String? token;

  const RegisterResponseEntity({this.success, this.user, this.token});

  @override
  List<Object?> get props => [success, user, token];
}
