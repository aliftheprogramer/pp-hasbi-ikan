import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? role;

  const UserEntity({this.id, this.email, this.name, this.role});

  @override
  List<Object?> get props => [id, email, name, role];
}
