import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_state.dart';
import 'package:pui_bhasbi_mobile/core/services/service_locator.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/get_local_user_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/get_profile_usecase.dart'; // NEW
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/is_logged_in_usecase.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/usecase/logout_usecase.dart';
import '../../../../core/resources/data_state.dart'; // NEW

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

  Future<void> refreshProfile() async {
    // Only refresh if already authenticated or checking
    final result = await sl<GetProfileUseCase>().call();
    if (result is DataSuccess && result.data != null) {
      emit(Authenticated(result.data!));
    } else if (result is DataFailed) {
      // If we get a 401/403 here, we might want to logout, but for now just don't update
      // Optionally emit error if needed, but AuthStateCubit logic is simple for now
    }
  }

  Future<void> logout() async {
    await sl<LogoutUseCase>().call();
    emit(UnAuthenticated());
  }
}
