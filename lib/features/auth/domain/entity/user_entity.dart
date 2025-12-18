import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? role;
  final String? avatarUrl;

  const UserEntity({this.id, this.email, this.name, this.role, this.avatarUrl});

  @override
  List<Object?> get props => [id, email, name, role, avatarUrl];
}
