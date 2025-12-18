import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class IsLoggedInUseCase implements Usecase<bool, void> {
  final AuthRepository _authRepository;

  IsLoggedInUseCase(this._authRepository);

  @override
  Future<bool> call({void param}) {
    return _authRepository.isLoggedIn();
  }
}
