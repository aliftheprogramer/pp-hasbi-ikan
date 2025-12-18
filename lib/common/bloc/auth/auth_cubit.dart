
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_state.dart';
import 'package:pui_bhasbi_mobile/core/services/service_locator.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/get_local_user_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/is_logged_in_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/logout_usecase.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  Future<void> appStarted() async {
    final bool isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      final user = await sl<GetLocalUserUseCase>().call();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        await sl<LogoutUseCase>().call();
        emit(UnAuthenticated());
      }
    } else {
      emit(UnAuthenticated());
    }
  }

  Future<void> logout() async {
    await sl<LogoutUseCase>().call();
    emit(UnAuthenticated());
  }
}
