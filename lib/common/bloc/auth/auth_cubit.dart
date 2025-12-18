import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_state.dart';
import 'package:pui_bhasbi_mobile/core/services/service_locator.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/is_logged_in_usecase.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  Future<void> appStarted() async {
    final bool isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      // Direct call to repo for simplicity, strictly should be a UseCase
      final user = await sl<AuthRepository>().getUser();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        // Token exists but User data missing (migration issue) -> Logout to force re-login
        await sl<AuthRepository>().logout();
        emit(UnAuthenticated());
      }
    } else {
      emit(UnAuthenticated());
    }
  }
}
