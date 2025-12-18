import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entity/user_entity.dart';

abstract class AuthState extends Equatable {
  final UserEntity? user;
  final String? message;
  final DioException? error;

  const AuthState({this.user, this.message, this.error});

  @override
  List<Object?> get props => [user, message, error];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  const AuthSuccess(UserEntity user) : super(user: user);
}

class AuthFailure extends AuthState {
  const AuthFailure(String message) : super(message: message);
}
