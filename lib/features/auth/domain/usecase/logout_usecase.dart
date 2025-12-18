import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase implements Usecase<void, void> {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  @override
  Future<void> call({void param}) {
    return _authRepository.logout();
  }
}
