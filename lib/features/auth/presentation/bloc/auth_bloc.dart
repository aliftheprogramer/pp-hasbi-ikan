import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthBloc(this._loginUseCase, this._registerUseCase) : super(AuthInitial()) {
    on<LoginEvent>(onLogin);
    on<RegisterEvent>(onRegister);
  }

  void onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _loginUseCase(param: event.params);

    if (result is DataSuccess && result.data != null) {
      if (result.data!.user != null) {
        emit(AuthSuccess(result.data!.user!));
      } else {

        emit(const AuthFailure("Login successful but no user data returned"));
      }
    } else if (result is DataFailed) {
      emit(AuthFailure(result.error?.message ?? "Login Failed"));
    } else {
      emit(const AuthFailure("Login Failed"));
    }
  }

  void onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _registerUseCase(param: event.params);

    if (result is DataSuccess && result.data != null) {
      // Registration might return user or just success
      if (result.data!.user != null) {
        emit(AuthSuccess(result.data!.user!));
      } else {
        emit(
          const AuthFailure(
            "Registration successful but no user data returned",
          ),
        );
      }
    } else if (result is DataFailed) {
      emit(AuthFailure(result.error?.message ?? "Registration Failed"));
    } else {
      emit(const AuthFailure("Registration Failed"));
    }
  }
}
