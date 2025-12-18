import 'package:equatable/equatable.dart';

class RegisterRequestEntity extends Equatable {
  final String email;
  final String password;
  final String name;
  final String role;

  const RegisterRequestEntity({
    required this.email,
    required this.password,
    required this.name,
    this.role = 'USER',
  });

  @override
  List<Object?> get props => [email, password, name, role];
}
